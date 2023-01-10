Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB38F664BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjAJTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbjAJTBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:01:37 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA9841A7E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673377292;
        bh=85RknxppdoIfRcVBRqufI454l6TbVoTb3DKGwQKrGJU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=f9dlMq8G+0BQxr0+YQn/LgGD3AwQOAGc3y+tpDWiGDgBV2aW58ycgD25BbrZ+Nqcq
         /reWxnPMX51NZM4V3n5wLC0Ue8g+h4E4JF2YRskJ8t6O3TYqJaGWNjhrtgMEeNd64f
         9z/JfYYZooYwLVo2dcCjvs30gAUh0iLXeXF3XQd8=
Received: from DESKTOPZMX ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id E9296887; Wed, 11 Jan 2023 02:58:18 +0800
X-QQ-mid: xmsmtpt1673377098t08fgkb52
Message-ID: <tencent_235CAC16001D1C38CE7D86BF7B0E365A2105@qq.com>
X-QQ-XMAILINFO: MAehWEgsdgwG0U9tdUQpl7f91kRFRXVMMpTqq4bj4YzJqpLcB557ScCL8E3kSm
         eeyu7zqKd1bUTmQtx4u1kZNEPuq+oH3OSPNL+zSLBr8c0v5jTWYxfw3HrcX3KD7eJ8g6HeKkjL/y
         +xMifwwwNk4uHU83clLc42cMXgdw9fKNnE3pDNfVTEeJND7ho2Syv2M3B8DU6CiKM2/ghZNwCA/6
         xfjRImjMrtjdXTV9My4o7/Hub6SadeKpFq1zh2o2QY8oGvjGqk+5laxxmbABMuSSREluBHiC6PgI
         qC+NTlBe0v9rNBRcDHAL2qBdHel52K6KWvVX3xiQIXOIHO5XmmkWT46N1tFDDlBlKg32n7iBAJK2
         eudEMW5Mn533WfHwZony3USdwDAM/af/y5OQ8AUlczVLjdaOiIlS4f+40cv6VOtnUt4rTB+tGTXF
         ta3d+TvOnGi6u8QDf7lB2PG1Poqj7q+SUTm7BgDbE+rGc/ieJBmkdWih4QwO3ORDjsrgbg1wz7J7
         yHEFsdE6POCe5SwZkXqiZTmtiJG5mwGHZVqMmjfeFIfPGyxuMh+vHQxWRI4Z1lLVbCcfXGjyZ2QM
         ZYxlss5EL35qF0UziT06Z+T2SQk7NU+yBohS9RSO0ztLOvDxUJIxVTtfP2FjVc6FfISpJT3cYaZS
         ePrVsK4Hg4vNIEiA8wPdhGO7wEwIBEm2JX926AqA2NDEvnmKyAYJNniUCV21Zz/SQGUvsI/8elgU
         +MjPFSqTpL29uIhLDr/J7ubje9jkpG3TW2i8rTRF5sK7UXcOLvr1vMS2Lmkczz0vwcyIo0Rfkihw
         WoHQECyD5pFib7LaDcGxkrhsg4Y+fKEocofUpQ0kiQ6za2cKqAGJ4X4sk3IxS9blgI98ueJVnBX+
         kZZC1GzHD5xxCr8I9oeqdRgnE69FiRF2hYKqgId9b4zNHLu8lp11abDtsyXpeVvI4+PNz4VQ7sQt
         U3nglNevmz4/orRF/njWJ634opNl7hsdXPn2DkGwpXRGTdfn7NmvkY7VUPFhxhx0aP2kN+ewM/Cq
         iZyCBCxA==
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
References: <20230110155014.31664-1-forbidden405@foxmail.com> <tencent_A7FA00B086BB0EFFDC1C64744FF85DAD2B06@qq.com> <8530aeef-8fdb-ede7-700e-856e5cbc6a5b@linaro.org> <tencent_98E029F744FE85B9FD68B570A45A01743F07@qq.com> <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org>
In-Reply-To: <f909c1b0-97db-cc33-fa27-c5e901f11956@linaro.org>
Subject: RE: [PATCH 3/3] arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe Wifi/LTE dongle UFI-001C and uf896
Date:   Wed, 11 Jan 2023 02:58:15 +0800
X-OQ-MSGID: <000101d92525$81100a30$83301e90$@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQEO7BERPzOKD8mdDN9nK2Zc/pFyZgG3SCqUAZiImfcCstHu6AF93epXAgGdVvA=
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

I removed Cc temporary because I had sent them the same email once. No need
to send the email to them again.

> On 10/01/2023 19:30 krzysztof.kozlowski@linaro.org wrote:

> You install this kernel with DTB on some device so clearly you have such
> device
> in hand, right? It has then some manufacturer, some company. If it is USB
> stick
> as you said, then it has even vendor ID, which might be or might not be
> real.

The vendor extracted from `/system/build.prop` and USB vendor ID is fake,
even IMEI is stolen from some other mobile phones. Seems like the vendor
deliberately tries to be anonymous. Some people had tried to extract info
from stock firmware and on the Internet. But until now, we have no clear
evidence to know the manufacturer.

Best regards,
Yang 


