Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332F5B4349
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIJAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIJAGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 20:06:22 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60099E9025
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662768374;
        bh=Od2g/eBR0jGaAPsRpmEX4/KiFYhWkxXju2yPrj37r1E=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date;
        b=EhgXmE/ybSF+gIMHKRlBL8ss8DLRYR2VTZezQs3Tp+8Lbf4dbVFY5Ec9lKZdW/Arq
         X0MmMEys2ZHmVpfC7zZnVqWuDrJp6Xd9hgYLbKLr+5rqjfYOHc06FN12d/pnFBm6TW
         0HS5kUv1Sm4eY3id5yyrD7RKs7KsbM4H3SYjW4Ns=
X-QQ-FEAT: oHWrrGTW1dDJ34LybywUcSCPpAkOV9c4
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMAILINFO: NDRJhlKLIrRLv53/erPnKkfIaPSvhnam/4Awyvkz2IpxlCeeYSWZUHY3NX/5XC
         9fWSMS88/y9YkpybcalLAq1XEH4Bx3Lxe5S8nHzQ6wgMBAL8mvdbWeW9zN/TrzAJG+hffatwLcpiJ
         6vRUNvlD4f3UOW1Klg+U3Q+sotM97IrBaZw8dw7tUGt6tbKXZUp28DJSHabjING1zbw0A5C2CRxgi
         ATORmSbRH3ruAS3i9iQy5eKUa9soUnoGBrToovUnSh9Eb6E2S313uJ73coopwOyjQqp4sGlYwLzCL
         NvEPwJocnweQEnEBJoV26PlLfUwOAP2H2fMpvowpQUo1aIBzeehdFOHsoeWrLUL72yg8ppZEIODbe
         gIzsGlW1z8ycCgH4G2xUSpAnink1ruu/1c2Lo6/zd07ew4wsfts1dlI2RGrINLxdd2hRdSDryXepf
         IuXHTZbSrHMArkPMxKIFKc3F6pnX6FL0F8UywoxjlRgTspjODQFwQ2O4Mvg02O5okaKCw3rVwhuvz
         x31Wtien0TEOqLs1qagGrYX9hYayuJ8glt2dPWe6jCLhdFlk2RODkKzIGhOa18jnSIe1OgZaJyGG5
         80EKS1nxiq6mtjnTX5d48gF0TbjPEU80nc3zu5qefgdKM/W0qZuA7otJJ7d17fuvw5Ix7S+RchqfH
         xZFUlYpJfZOvCVx7bKmHj2XWSD+2xmWsGruxnHHXChdjlM0btQbEfoUScki2ysVtQPbYB9Ct0jVaO
         BrEkDGpxbuSR6sLpVbUSxESky0oSLsvG89D5LxEzxfwkhLq0wDR+2Fb5E9wkpayI31xjFG9wqzoQ4
         nbRNIzib5iR08qNC+H2oV2lIT1PBDY7V65H6T9VU2kThyarDnCUjvgDYZzq3AjpZhc1ahYNAxYGMT
         RBbIxr8YOC3EnxHArLt8pwG+7Cii5IkI7KAipRBV73xzPE7a7WwJpLl85Bx8wx5odB68yUhR8+MQ0
         BwkAj71KEm/Lx8KDXSXlZeuZoAzQbP5rL5CloTEdwAZIQEdaBS
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.194.222
In-Reply-To: <659ff470-a912-4f35-6cbe-e3f49ba29dc8@gmail.com>
References: <tencent_7705902B66DA5C1C0E3E8ACBF077A5C3FF07@qq.com>
        <659ff470-a912-4f35-6cbe-e3f49ba29dc8@gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webmail740t1662768374t4637124
From:   "=?ISO-8859-1?B?WGlhb2tlIFdhbmc=?=" <xkernel.wang@foxmail.com>
To:     "=?ISO-8859-1?B?UGhpbGlwcCBIb3J0bWFubg==?=" 
        <philipp.g.hortmann@gmail.com>
Cc:     "=?ISO-8859-1?B?eGtlcm5lbC53YW5n?=" <xkernel.wang@foxmail.com>,
        "=?ISO-8859-1?B?TGFycnkuRmluZ2Vy?=" <Larry.Finger@lwfinger.net>,
        "=?ISO-8859-1?B?cGhpbA==?=" <phil@philpotter.co.uk>,
        "=?ISO-8859-1?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>,
        "=?ISO-8859-1?B?bGludXgtc3RhZ2luZw==?=" 
        <linux-staging@lists.linux.dev>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] staging: r8188eu: fix potential memory leak in rtw_os_xmit_resource_alloc()
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Sat, 10 Sep 2022 08:06:13 +0800
X-Priority: 3
Message-ID: <tencent_C279789E92CCFF2D481FB3492E1F87098506@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_EXCESS_BASE64,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBTZXAgMTAsIDIwMjIgMDE6MzEgQU0sIHBoaWxpcHAuZy5ob3J0bWFubkBnbWFp
bC5jb20gd3JvdGU6CiZndDsgSGksCiZndDsgCiZndDsgSSBjYW5ub3QgYXBwbHkgeW91ciBw
YXRjaDoKJmd0OyAKJmd0OyBrZXJuZWxAbWF0cml4LUVTUFJJTU8tUDcxMDp+L0RvY3VtZW50
cy9naXQva2VybmVscy9zdGFnaW5nJCBjYXQKJmd0OyB+L0Rvd25sb2Fkcy9cW1BBVENIXCB2
NFxdXCBzdGFnaW5nXCByODE4OGV1XCBmaXhcIHBvdGVudGlhbFwgbWVtb3J5XAomZ3Q7IGxl
YWtcIGluXCBydHdfb3NfeG1pdF9yZXNvdXJjZV9hbGxvY1woXCkuZW1sIHwgZ2l0IGFtCiZn
dDsgQXBwbHlpbmc6IHN0YWdpbmc6IHI4MTg4ZXU6IGZpeCBwb3RlbnRpYWwgbWVtb3J5IGxl
YWsgaW4KJmd0OyBydHdfb3NfeG1pdF9yZXNvdXJjZV9hbGxvYygpCiZndDsgZXJyb3I6IGRy
aXZlcnMvc3RhZ2luZy9yODE4OGV1L29zX2RlcC94bWl0X2xpbnV4LmM6IGRvZXMgbm90IGV4
aXN0IGluIGluZGV4CiZndDsgUGF0Y2ggZmFpbGVkIGF0IDAwMDEgc3RhZ2luZzogcjgxODhl
dTogZml4IHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbgomZ3Q7IHJ0d19vc194bWl0X3Jlc291
cmNlX2FsbG9jKCkKJmd0OyAKJmd0OyBicmFuY2g6IHN0YWdpbmctbmV4dAomZ3Q7IHJlcG9z
aXRvcnk6IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9n
cmVna2gvc3RhZ2luZy5naXQKCk9oLCBzb3JyeS4gSSByZWJhc2VkIGFjY29yZGluZyB0byB0
aGUgbWFpbiBicmFuY2guCkkgbm90aWNlZCB0aGF0IGluIHN0YWdpbmctbmV4dCwgdGhlIG9y
aWdpbmFsIGNvZGUgaGFzIGJlZW4gbW92ZWQgdG8KImRyaXZlcnMvc3RhZ2luZy9yODE4OGV1
L2NvcmUvcnR3X3htaXQuYyIuCkxhdGVyIEkgd2lsbCByZWJhc2UgYW5kIHJlc2VuZCBpdC4K
ClJlZ2FyZHMsClhpYW9rZSBXYW5nCgomZ3Q7IAomZ3Q7IFNvcnJ5CiZndDsgCiZndDsgQnll
IFBoaWxpcHA=

