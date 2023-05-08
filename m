Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519806FB4F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjEHQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjEHQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:22:35 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DA3A8B;
        Mon,  8 May 2023 09:22:34 -0700 (PDT)
Received: from [192.168.10.39] ([120.202.201.11])
        (user=saraday@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 348GMCEx006603-348GMCF1006603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 9 May 2023 00:22:12 +0800
Message-ID: <ecc36fdc-a87b-4b0d-bf2b-cfdd030b0600@hust.edu.cn>
Date:   Tue, 9 May 2023 00:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] bus: qcom-ebi2: simplify the code in
 qcom_ebi2_probe()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230430125154.126863-1-saraday@hust.edu.cn>
 <20230430125154.126863-2-saraday@hust.edu.cn>
 <CACRpkdZvTd4ibqhS2xQ_7BWLEkXzB_0qguccEV2X0d77KhC2UA@mail.gmail.com>
From:   Ziliang Liao <saraday@hust.edu.cn>
In-Reply-To: <CACRpkdZvTd4ibqhS2xQ_7BWLEkXzB_0qguccEV2X0d77KhC2UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: saraday@hust.edu.cn
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice.
Do I need to delete the Fixes in [PATCH 2/2] and resend another patch set?

> On Sun, Apr 30, 2023 at 2:54 PM Ziliang Liao <saraday@hust.edu.cn> wrote:
>
>> The code use platform_get_resource() and devm_ioremap_resource() to
>> allocate memory resources for the device. It can be simplified by using
>> devm_platform_ioremap_resource().
>>
>> Fixes: 335a12754808 ("bus: qcom: add EBI2 driver")
> It doesn't need Fixes: if it's not a bug, but who cares. Maybe
> the stable maintainers care.
>
>> Signed-off-by: Ziliang Liao <saraday@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
