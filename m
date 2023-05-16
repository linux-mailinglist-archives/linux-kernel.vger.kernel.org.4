Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E0704D30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjEPL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjEPL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:58:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313630F6;
        Tue, 16 May 2023 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684238298; i=rwarsow@gmx.de;
        bh=QyVpxP7UV0IwM3SDkHTYWapR+jd4VTxIP29MvcY+U2w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=NM5XpW7BmcvfcgjctJoJIaAMvKnZjJz8SKkGxM+rch1Pqef+kfBTkFcnv6cJi9b6r
         6nqVzHJmSzPM9egDx8Msukcn7x8ECG+mdXN/OmUVfF/lvfBRD6bxImJ8ROR8XjwXUP
         7DRuEsjAPANmM1KsvY7xLMwwYJVJCS8oOz9DDUfnmzWULcQIR8aHjWLWPW5Rgw6CYv
         sYGTvvSP6/9JkuDai9gNiKzPGjjOQmuqFu9QZUSFIbHAwJLs2PZVu5iwQvv5R6vWbp
         /LxY9O89sFn7qkwyzV/VLY8VRsjBVx9gAfxdO+U+zh9WFxeROmDYa1oaMhapWSY/SC
         qpKbtPRNBwssA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.42]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1q9MbD3o9C-012VNd; Tue, 16
 May 2023 13:58:17 +0200
Message-ID: <2ad80788-dda4-a277-f5dc-50784db4815f@gmx.de>
Date:   Tue, 16 May 2023 13:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HVDhhVqsSQvk2Fq8aXYmP3tiFC4dtfRqFRkzA5A8N5+qeF4cm3C
 gE8OavSajbfkxU8+PbhWPvqb6z/j315JQzUGTL34+HzaVZpLz4VvBkpLdDVla/xefeElmho
 0jWU8VZ2I/9aE4OVwAU8ODn+0LVYPbTVXTzounI7OLj6fajxlYe+w3dTpKt4lp6PVWTTnOZ
 63F6fBQB7aJTsFfPfFlsw==
UI-OutboundReport: notjunk:1;M01:P0:q1ArLY9+Kas=;xJwpEuZvbt29oNx3JUd9j+pMSRG
 1BvHojq/5eFQ1b5hkMpX2ajcc6xxsHzYEAMfgNlEtfpc4M63/L0iyH87dVSefOjaBSnY5VzrI
 JX0hC0B7NTxP3vzK2SWmHDC6jloOBaMhmVHHEaei2EKS5PFdqY5in66tX7Ld7BGFKVvq5J+sp
 RqU/dTwqMMe7E9ba/WnjxWKMeRpKWqftlt67+/Pr4le5CHJZY0julp8f3uoud6/1JMfch90ta
 2aKvboRFAxyDm8zqiKjSKerhNmltJxg0ETZdUu/xO39R5xu82MsJX+tjDdPGgRctBb7Pe4BGp
 RdQzMgSq73mwI7WkUimpEkwsrfYqoyVpBU07ylWt6o4jz6qzGBwc8gGbpoZU5Sb3ger00wCDK
 AuCfF328UioYODL44pS4m4RfINu9Hz10Ls2UQ1q+tSHhmoCTjcQT6THFbvZ6l56SACvQLNk81
 0AYJmFPq9oDQ1PBuZ6oUpqRkLVyZN/SqPrB17ftU7OLpDi27WWhmEAQeZ6hqsZjd1eahH478P
 b0WDdJkJv37XHKDU3HeeNOAOlvrr9Zp2h1wXKxyMKs+ra5SP48xfI/83JumrtIb2qUnP32j24
 0zzCLGFSCovaFshjGJEmvNtUFjN8WE577UXxK/qZysoHAhtGs6OGaFtyeJTX6UdCblCqtlCzT
 0vbKCez4TY5pwk4QW8S0qyF+cchE4Fotany/QQ6C0xAycXSjN3VuqAzjFyXyEw3wrLh5VzKUy
 8AUUcj8YY1ZdbwPfavJgzrYOP9bMNnl2Z6/A2FoMD37a/8vAu3Ky1wN0DxXynD56eHci0WcY3
 rHo9cr9ak1Dzok7/ChJ8tXngRa066y4/K2gFcY+qQHZfnwqhsDvbd2I5v/qf8atnBjSQYP//F
 g6g0hPN0BpmioYBdIbuk81dTcXT9zO4YbsEHy/UxFmSVSg9AQYXOi+Ya5ftC/2Oi6kgEfpt8y
 3oR8ew==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_A1,FREEMAIL_FROM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.3.3-rc1

compiles, boots and runs here on x86_64
(Intel i5-11400, gcc 13.x)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

