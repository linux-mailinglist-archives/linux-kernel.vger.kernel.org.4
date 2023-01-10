Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE34664CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjAJT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjAJT4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:56:30 -0500
X-Greylist: delayed 3417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 11:56:29 PST
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB0C5A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673380586;
        bh=dJPGXGPq9KBTulCLSUFI/aPlBFSMKa1WhssKqzEZC2Y=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=HmP87M7NpUUqziR/hEVmK12OJ+3uRtiOswSbpiRb+a+bK8bKvhlgJFquGmECqxUH4
         OIh28pThK1DqsSpZo053oMcfuwoXrPi3M3rVM9PJ/5VOLhv62rNrCmaC8s0xwT1QRg
         wZyhjypCn6NZmW8MT9WdRElKy4puD267EYDU9dA8=
Received: from DESKTOPZMX ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id E1732C31; Wed, 11 Jan 2023 03:56:23 +0800
X-QQ-mid: xmsmtpt1673380583tnsq6la7s
Message-ID: <tencent_2068AC70F1DA5AF46F600C7718FEB1B98307@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt2HZBdB6iDcLNo7CbPXDbza3p17qBezTWrUQVdW2Q3oewXlL3EV
         qF9NvGfZROeL8z0kjtTlanFxyq9wOmhX2Hjq5zNa14eI2w2Nmgr67WoFxzTNvN/zxSCxwSp3mZrO
         6DppnI4pXqVCeNt+kkJ9nYZnn+myKjTg1+JwSCxzVHpqenX1fsgb6CRM5Hb1rP5tYeGw8RMj94WG
         iAyP8wn4sZ1xlA8S5HpCMDkaHJFiuNPKZ6l8VMcqRdA+oAvMO//8lMXmrNsumzWzxiPaLh/CiiUv
         p4kAF6DP5qwRlkiQurQbNuS1Fa0xO4V7vTsFVjqVCXajzEW3NeIZrSBomFTUr959VMYZeCiB3pu2
         cQl0E9zvbFn6qnh0b/U2m3Ma90IeMxPnwfvTOCw6iVH5FK0kz7RFt39rJfbjZzgRB/p9+GQ4v+q/
         HKPZo4XgUSF48+p9wPAILGmuhy0I3k2JTH5dwJ+BPf4g+kvCbI6rdhlKjz1jrZ41A1VbXdMt9VCn
         VUWJiJemz3COU0CNiJ0p7QpXXCsosuIN3imMpTPXyZJd/4fGo40QAxmrl5887Q3XLEvP/vGMj49n
         ME87hWjUVuKWzT46eqnSw+bffJuEJ7VFga9sOnXO2l3CMweUZegDffl8s9TSVS5z88RWozv3Bds2
         gFoa+r81IUAfEOWeJe6LiD4bYKj9II+JuNAT6VsC/ZKhuS5cA2lDLS9slCDCHjP+wPFMLmfIef/W
         Ata/4vtutveO7KNnrFLwXwcKSzfdXh407Kt462NpIier2sj85NLIyI+TYhI/SaBDun5H8UxjHBda
         q4TK9smcaW6OMUPqwS7tChi3M7gDCkRFJTs32z3/ZqOkQcHLSZF4ltGmqjAtgtD28IAxnR1OTYQw
         ulSWkR4GMZtO6U3AP6BR+zwx5anOaKnqOZTIVUIs/vYrsAcGT477Aa+NsYPEAZSI09vXwTRnhcj5
         AMxmwuBiEh8bBeT3yJmJ901g9NX3Q8a9xuDLjq6sTlqHAw2tLoR5j52OjfHm0h2Z9BOwB0fvvWfA
         q7nnOqow==
From:   <forbidden405@foxmail.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Jaime Breva'" <jbreva@nayarsystems.com>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        "'Nikita Travkin'" <nikita@trvn.ru>
References: <20230110155014.31664-1-forbidden405@foxmail.com> <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com> <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org> <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com> <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org> <tencent_235CAC16001D1C38CE7D86BF7B0E365A2105@qq.com> <0453b098-91db-1918-38ae-a7db0408460c@linaro.org>
In-Reply-To: <0453b098-91db-1918-38ae-a7db0408460c@linaro.org>
Subject: RE: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Date:   Wed, 11 Jan 2023 03:56:23 +0800
X-OQ-MSGID: <000301d9252d$9f377c70$dda67550$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEO7BERPzOKD8mdDN9nK2Zc/pFyZgG3SCqUAZiImfcCstHu6AF93epXAffz5noBRJuEca/Wk39w
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 20:32, krzysztof.kozlowski@linaro.org wrote:
> 
> Then I am not sure if we want to support such devices mainline. It is not
only
> anonymity but simply not following standards and practices.
> What's more there is no guarantee what this device is. If there is no
known
> manufacturer, anytime another device from anyone can claim it is also
uf896.
> IOW, what guarantees you have that other person who has something looking
> like "uf896" actually has something the same as you and can use your DTB?

There is a label printed (i.e. ufi001c or uf896 or something else but not
getting mainlined now) on the board, different models have different
labels(and different board design). And currently I know all ufi001c(even
some other models) shares the same device tree, as a downstream device tree
has been tested by thousands of people. I'm not familiar with uf896 as it is
owned by Nikita Travkin and tested by him. The device sells very well and
many people will benefit from mainlining.

