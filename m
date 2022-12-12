Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E864A35E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiLLObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:31:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7D12ABB;
        Mon, 12 Dec 2022 06:31:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D416D60FF4;
        Mon, 12 Dec 2022 14:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBACC433D2;
        Mon, 12 Dec 2022 14:30:57 +0000 (UTC)
Message-ID: <481d69d1-e073-1b77-e222-3b317c1a6d0f@xs4all.nl>
Date:   Mon, 12 Dec 2022 15:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 4/6] media: chips-media: wave5: Add TODO file
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, Nas Chung <nas.chung@chipsnmedia.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, nicolas.dufresne@collabora.com,
        linux-kernel@vger.kernel.org
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-5-sebastian.fricke@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221207121350.66217-5-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 13:13, Sebastian Fricke wrote:
> From: Nas Chung <nas.chung@chipsnmedia.com>
> 
> Add a TODO file with remaining elements to be improved/added.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>  drivers/media/platform/chips-media/wave5/TODO | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 drivers/media/platform/chips-media/wave5/TODO
> 
> diff --git a/drivers/media/platform/chips-media/wave5/TODO b/drivers/media/platform/chips-media/wave5/TODO
> new file mode 100644
> index 000000000000..2164fd071a56
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/TODO
> @@ -0,0 +1,18 @@
> +* Handle interrupts better
> +
> +Currently the interrupt handling uses an unusual design employing a kfifo to
> +transfer irq status to irq thread. This was done as a work around for dropped
> +interrupts seen with IRQF_ONESHOT based handling.
> +
> +This needs further investigation and fixing properly, with the aid of
> +C&M.
> +
> +* power management handling - add (runtime_)suspen/resume cb where the clock is enabled
> +
> +* revise logic of wave5_vpu_(dec/enc)_register_framebuffer
> +
> +* check if the  normal kernel endianness/__swab32 routines are sufficient. (instead of the ones
> +  implemented in the driver)
> +
> +* Adjust STREAMON routine for the stateful decoder to adhere to the API, which
> +  declares that STREAMON can be called before source buffers have been queued.

A TODO file doesn't belong in a non-staging driver.

So either it should remain in staging if this is serious enough (and I'm a bit
worried about the last item here!), or it should be documented in comments in
the driver in the appropriate places.

Note that the "revise logic" item doesn't explain the reason why that should be
done.

Regards,

	Hans
