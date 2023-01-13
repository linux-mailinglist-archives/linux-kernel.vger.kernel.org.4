Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FCC6688CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjAMBBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjAMBBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:01:16 -0500
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04815E1C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673571670;
        bh=5YVu9mqcRPbCqohsQNwc03vAe6oCgMQmSEOp7fMl/DM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=A6MrL/sn5q7p3/sPOTgjq7oPc8SK7wVp7eLeZ5alnDzVjBkOHlsyt23kxYfp6naq0
         M0jkXgfideZLgH7MZoz6Z+WtBO8Yic1LhArAVJf0j+G8X926BpWx+ijbBFnjMLjCqs
         7qS9cpLUQp3Pe6Xll3VVwHkGZYwvQyhvrc2rUK14=
Received: from DESKTOPZMX ([111.60.247.106])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 462CC10; Fri, 13 Jan 2023 09:01:06 +0800
X-QQ-mid: xmsmtpt1673571666tgdfgcdep
Message-ID: <tencent_D4DA0F74026037777CFE86B9EEE8E870F807@qq.com>
X-QQ-XMAILINFO: MZHbDvTHakKc4qRpdkAgWdtQzh8SftSzsSF49B8tJh2GsdhDIVBgF/KEngk2Im
         kJsFBXUjyEoA61nx+0YG+bixUddlyXv6BHDXDQE3LYfXbs3uKd96SWXCuFXuLl7bs0G/aReVNeH2
         1YX5Rgejip6klhwQdyfrsvVF20qBo5GxKfcX9zMCv3d7CJ6ERIE7MuONTEZC9VlXYhjQpTRF4Y2o
         ODeo2WYE4ebfZ05FIFhmbn6+pHIJGEl96BHexmkXM0PVop9fKYWAE116FhIFiJF9gjymj0olq9B4
         gmmEA6bFXH6iRksyY+vPKOhppH1svndSemZSRV6bGIe4dSDtnwgdjld0nUFXV8QRhMxvFF6BzCRJ
         cyg7QU5g4rvL+Gpo2i5JbQ8s2yNu+9I6wl+saMHtLS03Ddxjlejp9RVWEP/7WDwnc+ZTf4YJFSfG
         G0M1nUto8LhkkG95g4604rhRuGFCHFK5xpm5e2aCniFAEDXAOIqYW3k3xCCjTfS2cTCHw8onGcsM
         N88lJDomTzzLMm+Bq7P9h5MACEQpszDbluzgeqK2WEjEb9FqgugUbbgqT0MzDbyHkykgVPtD8BrI
         TjEAwk22USga4cxNvmprms+zvF2CjKF6JBDNby9xocA2mm8fmiTZTpXnHjNlgGWEpz4EGajy6a1i
         fPshe44VO8EqupBtPY3qWK+nYu7hKxbIQpX3oir5q7lwEQSK39QpeZO7Rxs20P0d99VtRzo5HOJK
         GT3Y8NNs3w+1TtIpXnxA14cpsgpil3RxLhriQPUCHMO8deB7Tv0UZy7Vk0aMbW2A6g9wbcQ5jIae
         S75D7wPiHfiFcNK4WIfqgf3AvxOdI4BJ7TLozpeztt7KFqky5SCyaT1sqJFobQaOX8SlKUM7rqnS
         i9uXoeuY1QZaXBxnCvQT/qq/+qCaFp444qzVWIo4llz6Ht3cg0dZx3mZH8419zCIVk0M/glAcd
From:   <forbidden405@foxmail.com>
To:     "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Jaime Breva'" <jbreva@nayarsystems.com>,
        "'Nikita Travkin'" <nikita@trvn.ru>,
        <~postmarketos/upstreaming@lists.sr.ht>
References: <20230111141311.14682-1-forbidden405@foxmail.com> <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com> <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
In-Reply-To: <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
Subject: RE: [PATCH v2 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device tree for Tong Heng Wei Chuang Wifi/LTE dongle UFI-001C and uf896
Date:   Fri, 13 Jan 2023 09:00:44 +0800
X-OQ-MSGID: <000801d926ea$858c56b0$90a50410$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKxbg4WubPzuE7WFcN4pGL8ECeU5QJyz/rKAUsDSSqszQolEA==
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.2023 16:13, Konrad Dybcio wrote:
> > +&sim_ctrl_default {
> > +	pins = "gpio1", "gpio2";
> Identical between both boards, move to common please.

It is just happened to be identical for these two boards, but not true 
For many other devices that will be supported sooner or later.

Best regards,
Yang


