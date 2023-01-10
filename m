Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAE66495E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbjAJSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbjAJSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:20:09 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84586DF1F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673374675;
        bh=TO5uIw7LawmTRUVg1uOWAoT8iMzgTp3NUNuLS9n+qFw=;
        h=From:To:References:In-Reply-To:Subject:Date;
        b=rpHqwePUdnF4j5fyJuu6+iPZawZ0FJ3CAusIWVCljBtjz6AaGeS4h7s7imCagYr98
         qvXzecrrS7UCcdFsSZROLGLtFJm9ByAa9Y1TFB/qbQ4BqlsTqEPHlWakMUo2Is4gkt
         tfzqyze/ox7IO2YjBO8jJuvr3HGdiC1e/jwB+1ZY=
Received: from DESKTOPZMX ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 474A6EB3; Wed, 11 Jan 2023 02:17:52 +0800
X-QQ-mid: xmsmtpt1673374672tjhvya1qy
Message-ID: <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com>
X-QQ-XMAILINFO: NJRsSVeNb6U+epZkfnlGQVAFskOSIaqZ6s4RfLzRaOB8PUX6bvtmSKJes7jgZh
         rrdYabgWm5MneQOrWKYq4czEB27cTdk7t21B80s///zWH4m1jFjHLuEFdjQKiE4QXxa+hNv7sFC+
         0a6B1HwdHiRLh5iTBPwsSU5SVVxzXagmawtAmZgLh3gQS0t8vuNh8FkY6fbkqRG5VID65J/1UN+s
         6i4CStYOfG2WVC9EbSZxahxGJo4hjxf63wzOHAI/LxGrtDNM9yGobnzwm2BcGhyRQQZqRZSejDnL
         6y1wEz/vXCPMsI9LFm7uM6tmtOU+c/sTE7dGwPYUk8amci/Ns7b0Q9bVecXYzvM0ifddEVh1EJnv
         ZlXlL+jg4Pt0s2eLwBMO7Voick5cjR81oPGJYXsKR+CzmA0ePTeSqjnYmGJr1YzajQGP+VCt11Kr
         p+wrelDQgdYS48WRmyPlyD2QXH1qrKtk56N9l025XswifLovLA8KlMZw9l9kn84k4b8m0Cwt4YQO
         jnsRi+jf0Rj+whfTEr1BtvA3QB2q+8Tog3NRf1fRblMVH1o3giXciEO2vpNDdxX8+NK1rFSVAnxb
         0KKRnpMBwWSjHR06tM1+gQBIkw36NeK2F5aG+RESR561y8VvBhDJggsjYAo6J6QUGHagdkuRToo1
         eO+CgPqpyzlbmfPc6JP3MOirlF4vLSBOwsAGnbbQXPFN7e3RPYKYSydMbe++baJ8pkeOaf/GyH1A
         EaZt1F3Rvwwn0nYjuf6UmpLJWOCgNtlw9Lh3sCO8Zj7+a4LveSxrn1wLGQBgxOk6fLVw9GKdxdYk
         NphvFhb+HA1f1bE8OcabWmSpB8gfMpwY5I/Q8dvJbXC60TxXOgViAYNgL9O+NdL/neFqkvmC4rDc
         W5nvjCu91m1FOd1zSsA9gJoYcxhbI4C5pxbrsVh/DoiGFI7jdTSmn1L4vkoWqjeHfIRk/BVr+W2c
         NvOUaxFWI=
From:   <forbidden405@foxmail.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230110155014.31664-1-forbidden405@foxmail.com> <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com> <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org>
In-Reply-To: <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Date:   Wed, 11 Jan 2023 02:17:49 +0800
X-OQ-MSGID: <04fd01d9251f$da0e89a0$8e2b9ce0$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEO7BERPzOKD8mdDN9nK2Zc/pFyZgG3SCqUAZiImfcCrwVvdA==
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review, but I don't know how to deal with such a 
device with unknown vendor. Do you have any idea and show me
some possible solutions? If "zhihe" is dropped, what can be a substitute?

Best regards,
Yang


