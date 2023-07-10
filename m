Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DD74CC62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGJFr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:47:54 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5DDE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688968052;
        bh=xTvL2e6wK/GytVnhPpEJaEjWTVzGVbzLIg6DXCg+z60=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=zX8WBaQOI4GZfTbltzAy/0MLwOQVJlxfnAai1yJcZSvV0/loOnft/88GUlXjvkFVr
         sChbSXPtXwqopq1eqJsVRD/jJzoFE2GgvZN7CNPcRAZCQtFzcOEDv14ZG22NRZUmMU
         IvNU+IPfmjWjBNvxwvCnjl+v0gwu5c1iuSK/+uPM=
Received: from smtpclient.apple ([240e:6b1:c0:120::b])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id A51BB0C9; Mon, 10 Jul 2023 13:41:17 +0800
X-QQ-mid: xmsmtpt1688967677tr407q0zf
Message-ID: <tencent_BB4124566E846A2FB6ECC0F63C5A15BE5009@qq.com>
X-QQ-XMAILINFO: M0msBj/q2J/mf9gFfHhbU6RzGy6V0ipaK3fxvRF8YcN2FLrRemnAU6zZD6Ph7G
         qPj+awM0q9VUD8jNFc6VQQJP91IzHZXYMXmeEWjmDsIcL7TEDbc5YhwUKkiyIfRF13O4e3O0LGfo
         FowAEwoHrBD6RQizdfLkSKCOpL3t+kAEviQB3GuiMp65a7Kfc/sdKOEnCFi9f1R3MVvBUkDAUtmL
         9X6EDQ5a23LkZlw2eML8xsnzyjK7UKhonil2zQRuE3rRQPB1QKHtDHI/9TBwc48GUYUEcaAx9QCW
         qvADUxrxEiTzl3kkiEhElKYnYKsDq1dVQCZIuvuQE2Upmm0xHkk7uBFE4/i4cobyiTDk/eW8PfOH
         dkYpQJqffa42tXTgYeXedC0lHZsGwUa2Y8Ale6SXo7YzVKZqKAM4oMJV0ff6grzKZNAGgn8TU+zj
         tYd+wxbNcq62/pph7jV8xS6zCTUTFaHPaKPP1LyvKviyWitSvxP4p5cCASIsh/XEZm0C6LwHsIPI
         kli8t0/U0sCDQ/ZMh5b+W0OIiqCan2+9Y3ZhKUH2edbHwt5yK+BnL0L7sq+U4mudRx1zu7Pe/g0d
         nYsw22CX4hVdLljHWQ5mMNQTBvgvWgj/eklPSXEFhnjIe0mkHmRBMMJOhpMmFb6GwhDV4dxiyBFJ
         yBQ6MO2TQs76od7MotNzxpGbgpADcjqaHU5ICQz3i5wPuhVzd4aqDEjJO91/w5BeSSgehJCRJ6h2
         w5tAAw3WFGDhEYzOsLCM0JM6/gLMALmQ+YSlFb3wTKPl5ApPD1ZEd/Y5jfktUOFVZr19I5bOe6Gt
         9V5KOeQOaPUgcns2pcnYSfI8nziVQT6vUUdch0FApzjSQtbjyPjSgkxnItboR2gPapY5jqpgfnhk
         9jelCszPXYZkb1/LI/PtRv81N13PTh1Q0LzNRVdUTj4+nlpL+9adsDL6cvHqzb7oPMWnaiC8v2SA
         3PLa9R17XaPLpXr7Xmp9nMmEMJJ8zAu19G18H1XnRNL0T9et0vI1N07+q9r5ep
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: staging: ks7010: potential buffer overflow in
 ks_wlan_set_encode_ext()
From:   Zhang Shurong <zhang_shurong@foxmail.com>
In-Reply-To: <e24f9c2c-1163-631a-f8c0-b6dcb445a858@web.de>
Date:   Mon, 10 Jul 2023 13:41:07 +0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Xu Panda <xu.panda@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <BA41CA41-19D6-48ED-89CC-B7A575DC0040@foxmail.com>
References: <tencent_5153B668C0283CAA15AA518325346E026A09@qq.com>
 <2a41ca22-a0eb-df38-be43-7175e1230bd0@web.de>
 <2023070919-monetary-sleet-2f5c@gregkh>
 <e24f9c2c-1163-631a-f8c0-b6dcb445a858@web.de>
To:     Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

> 2023=E5=B9=B47=E6=9C=8810=E6=97=A5 03:56=EF=BC=8CMarkus Elfring =
<Markus.Elfring@web.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>>> The "exc->key_len" is a u16 that comes from the user.  If it's over
>>>> IW_ENCODING_TOKEN_MAX (64) that could lead to memory corruption.
>>>=20
>>> Please choose an imperative change suggestion.
>>=20
>> Please stop reviewing staging patches, it is not helpful for anyone.
>=20
> It seems that further contributors need to become more aware about
> (and finally adhere to) requirements from the Linux development =
documentation.
>=20
> Regards,
> Markus

I'm guilty of my incorrect patch format. And do I need to write another
patch to fix this format issue?

Best regards
Shurong

