Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB165FE5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJMX3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 19:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJMX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 19:29:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE611C16;
        Thu, 13 Oct 2022 16:29:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j16so5114571wrh.5;
        Thu, 13 Oct 2022 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQnVKFik8dqwuZutsaP9cNDvZ0PRerS9sNhgzSHufro=;
        b=e6EI0xXNAOAWlC5Z6oZNisuHv5fUaBQTjlDCzoG8pkAjpkNYwJqzTib+nzdY7Ro5kH
         rAjocorKSedkC7bsRdYtK8Ab/S7h1u3maZ8c4uW9aNBriNnDYiECMidBvKhOJrDNz3lQ
         AOueB/FlyxKy/mVHH2lyL84XejcO+JC7Pn+jjvmZKC5bAAwfcpwiGDP5waAfTRFlBYiL
         TA6vdvqlDrr2QXemdBXs4XXVsulGb3Ui020nNw7A0P9ec8UVplY1CKKK6QZPTkxLD3bV
         FHrirZjR+/nwizvVgc9yluV03t/eLttD+7HJKetNdleALAyt0urDZA32L3EvgvuFrCnt
         JmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQnVKFik8dqwuZutsaP9cNDvZ0PRerS9sNhgzSHufro=;
        b=h0+s5EAmdx+pbV+joUhTK9MJ3egmRnezvM2PgrT/AR8yJqI2AUFiQxFGPhwY+FiTE9
         tJflb3Nt0EifrMHhM8O/ESTuBCciTAw/cxbvPvHUrNr8S3JkNcY8W3ZX6g7iP0i5ceVt
         WtMyOofhwBnYpd85f9p+GzselGxj4rMAh2yvmpALqw+65NMYz9QyP33EkXQPldigXMLX
         tT6qKtI4M7LRRyH3XqQQFhmlroTFLsciMcbcTsGkcJfH8jvaEYq0mGLI26+U7TpjMPvn
         7Xu1GeG7x+Qt+aHj9FmxWRWzaCHnGMwh2kAVymaAf6kzr6aKGfCGl9aCeR6V/ubUKaUd
         vHcw==
X-Gm-Message-State: ACrzQf0KHnUy1sv2zqy/ntQUqyJlcVkp2ZNSHGT4AMaHDNMqxU1sGlHg
        mk+ga+aiE4PXmWQ39NwJVkufxH8B0KE=
X-Google-Smtp-Source: AMsMyM7eSFDKwgCZACSGgPUvdFt8inoqpHf+Vi+qizQl5fSitv9YC9yx5CAdR2sBh+4gX46R9b26pQ==
X-Received: by 2002:a5d:4909:0:b0:22e:7bbf:c8d with SMTP id x9-20020a5d4909000000b0022e7bbf0c8dmr1403689wrq.80.1665703782911;
        Thu, 13 Oct 2022 16:29:42 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003c6cc57566fsm4544617wmq.14.2022.10.13.16.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 16:29:42 -0700 (PDT)
Message-ID: <c5c0f5fa-0ff5-7fdf-4a1c-2cdd4563d781@gmail.com>
Date:   Fri, 14 Oct 2022 01:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: man-pages-6.00 released
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, groff <groff@gnu.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        Marcos Fouces <marcos@debian.org>
References: <364ecc74-4e97-a1a3-7480-7914f28dcba3@gmail.com>
In-Reply-To: <364ecc74-4e97-a1a3-7480-7914f28dcba3@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uSdrlzydy7XbXkuv20f3RxAn"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uSdrlzydy7XbXkuv20f3RxAn
Content-Type: multipart/mixed; boundary="------------TqkMrIHfIhSjIHsd4XtEb4Jr";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Michael Kerrisk <mtk.manpages@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 linux-man <linux-man@vger.kernel.org>, groff <groff@gnu.org>
Cc: Jonathan Corbet <corbet@lwn.net>, "Dr. Tobias Quathamer"
 <toddy@debian.org>, Marcos Fouces <marcos@debian.org>
Message-ID: <c5c0f5fa-0ff5-7fdf-4a1c-2cdd4563d781@gmail.com>
Subject: Re: man-pages-6.00 released
References: <364ecc74-4e97-a1a3-7480-7914f28dcba3@gmail.com>
In-Reply-To: <364ecc74-4e97-a1a3-7480-7914f28dcba3@gmail.com>

--------------TqkMrIHfIhSjIHsd4XtEb4Jr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkhDQoNCk9uIDEwLzkvMjIgMjA6MDEsIEFsZWphbmRybyBDb2xvbWFyIHdyb3RlOg0KPiBH
aWRkYXkhDQo+IA0KPiBJJ20gcHJvdWQgdG8gYW5ub3VuY2U6DQo+IA0KPiAgwqDCoMKgIG1h
bi1wYWdlcy02LjAwIC0gbWFudWFsIHBhZ2VzIGZvciBHTlUvTGludXgNCj4gDQo+IFRoaXMg
cmVsZWFzZSByZXN1bHRlZCBmcm9tIHBhdGNoZXMsIGJ1ZyByZXBvcnRzLCByZXZpZXdzLCBh
bmQgY29tbWVudHMNCj4gZnJvbSBhcm91bmQgMTQ1IGNvbnRyaWJ1dG9ycy7CoCBUaGUgcmVs
ZWFzZSBpbmNsdWRlcyBhcm91bmQgMTI0NQ0KPiBjb21taXRzLCBhbmQgY2hhbmdlZCBhbGwg
b2YgdGhlIHBhZ2VzLg0KPiANCj4gVGFyYmFsbCBkb3dubG9hZDoNCj4gIMKgwqDCoCBUQkQg
LSBIb3dldmVyLCB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gZ2VuZXJhdGUgbG9jYWxseQ0KPiAg
wqDCoMKgIGEgc2V0IG9mIHRhcmJhbGxzIGZyb20gdGhlIGdpdCByZXBvc2l0b3J5IHdpdGgg
YG1ha2UgZGlzdGAsDQo+ICDCoMKgwqAgd2hpY2ggd2lsbCBnZW5lcmF0ZSAudGFyLCAudGFy
Lmd6LCBhbmQgLnRhci54eiBhcmNoaXZlcy4NCg0KVGhlIDYuMDAgdGFyYmFsbHMgYXJlIHJl
YWR5Og0KPGh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5lbC5vcmcvcHViL2xpbnV4L2RvY3Mv
bWFuLXBhZ2VzLz4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KPGh0dHA6Ly93d3cuYWxl
amFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------TqkMrIHfIhSjIHsd4XtEb4Jr--

--------------uSdrlzydy7XbXkuv20f3RxAn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNIn2QACgkQnowa+77/
2zK24g/9GaarOkkpehZ6TTv0Ldi8bA8+y67ojLzGF/H2nyvtrTHkfviwX2m7EFhm
wZLMLCo+4Qxay31lbBzHppV4Jd28Xj9M7BPGaTN3JWgPsztXTFJWQoK8z/p4e6sD
C+/m+u/VkbWxCB2GKkvCs5Ae0Xc5wsoRkwA/5cdaNxMS4VtjtabFPkgw6y4fo3Ia
z/8HM4LKdyWsBLbnWQLu1ltEc8AbOttxyrWnUskcFLA73nw5pxVJaAOKDDEf+oc5
gdJ+uy+BV8uPn2iZrWGdhS6QhFZDqnnHkHLvAatpBvV+O8wPUhWm1EIkGG16BHrf
kq+gmrPzfQlqUQx7Q4EeerL6kY4OxLhkq0YlK2hQxYrB0Xq38cBRiooXd6lPaEtf
c5CPIfqVJjz2qxxJLZxVGb+2tyWpG89+p8keYueAJZJNpT6MRNj1Xme/L56j8N34
/FrHqsxmzG2V5jD0G3gstQ/V7eEJx94q0vc1AjzPmB0tb0cg0vwpXtzrdMNCkhIw
0eEUBIE3r7gt1mxFw6J1vEMH/HGC/Bk2bIG9tsx6LvgOxtCILu0C3/MJs7hJqi88
pX0Vj6gik3wyRmG8XfIKXY/Kg7H5Ptjm64MVa/3WLlUlX22Nr/tiUFWAzfCgOh2B
4cNeqKxF3QyqhZbExe+iq5trJuJeUUVx9pG2P3mE4yFMkWf5pvs=
=9hun
-----END PGP SIGNATURE-----

--------------uSdrlzydy7XbXkuv20f3RxAn--
