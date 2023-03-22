Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C386C4671
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCVJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjCVJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A2F59E5E;
        Wed, 22 Mar 2023 02:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B1FEB81BF0;
        Wed, 22 Mar 2023 09:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64136C4339B;
        Wed, 22 Mar 2023 09:29:46 +0000 (UTC)
Message-ID: <eb09f4a7-f923-3f5f-ec95-0d07668ee275@xs4all.nl>
Date:   Wed, 22 Mar 2023 10:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH v4 00/21] Add Tegra20 parallel video input capture
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
 <20230322101417.4561a7ae@booty>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230322101417.4561a7ae@booty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 10:14, Luca Ceresoli wrote:
> Hello,
> 
> On Thu,  9 Mar 2023 15:42:59 +0100
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> 
>> TL;DR: Resending this series with Rob's review tag added. Now all DT
>> patches have at least a reviewed-by tag from Rob or Krzysztof, all the
>> driver patches have one from Dmitry.
> 
> This is a gentle ping about this series. All patches have a
> reviewed-by, there are no major changes since v2, and it's touching a
> staging driver anyway.
> 
> I don't think there is more I can do at the moment besides pinging, but
> should there be anything, I'd be glad to know! :-)

I actually started on this last week, but now I am abroad again with no
hardware access.

I hope I can resume work on it next week, because after that I am again
abroad for 10 days or so.

It's currently very high on my todo list, so I really hope I will be able
to make progress on it next week.

Regards,

	Hans
