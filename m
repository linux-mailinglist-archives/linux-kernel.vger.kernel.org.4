Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854BD658693
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiL1T53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiL1T50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:57:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D912770;
        Wed, 28 Dec 2022 11:57:25 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z10so15725646wrh.10;
        Wed, 28 Dec 2022 11:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iWWM5HBnxZTnzsqfsNwudjx2e2L6OFca5hFA/CkMLg=;
        b=dFEE/CgXN6VMgzULqrsH4OO67FJtEvk65BhlacsmgLKSgVQG1bsuSnD6hcRuvpEvLH
         RnJ4IJOUrHvWomnjN9fguiu6bITQ7mbz5xHV45i/3vnCjbvI/SdoBJDA2N0itKbTwej0
         tIe3r9mT1cAD9CHqTp1LPBBhHXYLo6XkIVvi8irATqi5zLEjXd+bTGGSNasAgkL6u1Oh
         TeCN2MvaJSffgzqqwfNm09hFf075L3PQEQIEOzLwyiS3MVuF4lLmiT0FTYHTjphdck6v
         0MCjyTrVhhPMzaeN1R5cH/2VO/ywEelGB9uPYMyhSfLEhrU57xbkMhRi2sp2751noljZ
         7F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7iWWM5HBnxZTnzsqfsNwudjx2e2L6OFca5hFA/CkMLg=;
        b=zjZTX9S3C14YQ59Wt2waFCYBjeVA3W2DoZFAQzbCcmMvaeY+YNwHpS+gz/1NlWWlEt
         rskGHuuQqRhpKn2O0KKZgEsGeAC2OFAWsLbEENGT/bum3CLFj/KOf7/yXAi9bXMLL09j
         8sPzqpxp4pzLtMQLK65IJCsiW1bSWLSDcVWMP32lVKxmtfjsJBytEP7uz6khpe6o0O51
         1DvJFNnGCYuwnx1fXmw4vI02noMb8k71LZNrS/aSE2qBdAoJSYeGsM7kVRCdefdrmQBa
         s2xyoU73SQo6YMg7qfBRLYZdERljvQH51HfUZbgGpYKGLV7ICOEiqcQB+HZwyhJewkSc
         YP9Q==
X-Gm-Message-State: AFqh2krBV2pjQnsRDT7L5Wd7Uv9Np8hADy8X5yRgOnOCEKg2DRgZ5GAS
        m2XHY1EKFokelVmLi50BJCI=
X-Google-Smtp-Source: AMrXdXuLESOyOjZvL9HtbF43HfqRgS7qaQb87x2ZIjH/uvbuVfL5Vtih0H6mR4iIUtB9joy4CsJxhw==
X-Received: by 2002:a5d:6ac1:0:b0:284:2216:c23e with SMTP id u1-20020a5d6ac1000000b002842216c23emr3941322wrw.44.1672257443786;
        Wed, 28 Dec 2022 11:57:23 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id r13-20020adfa14d000000b002779dab8d85sm12596851wrr.8.2022.12.28.11.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 11:57:23 -0800 (PST)
Message-ID: <551c6d28-2b4e-ce4e-7602-29afe014d725@gmail.com>
Date:   Wed, 28 Dec 2022 20:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
To:     Shawn Webb <shawn.webb@hardenedbsd.org>,
        oss-security@lists.openwall.com,
        John Helmert III <ajak@gentoo.org>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Jan Engelhardt <jengelh@inai.de>,
        "Lyndon Nerenberg (VE7TFX/VE6BBM)" <lyndon@orthanc.ca>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca> <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email> <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email> <20221228192436.viuoyil2ntr4lxjo@mutt-hbsd>
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20221228192436.viuoyil2ntr4lxjo@mutt-hbsd>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uQsnnfGhGlsKwv1EyHZlFxph"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uQsnnfGhGlsKwv1EyHZlFxph
Content-Type: multipart/mixed; boundary="------------GxGiU4j9OA3T2C2mhp0X8dga";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Shawn Webb <shawn.webb@hardenedbsd.org>, oss-security@lists.openwall.com,
 John Helmert III <ajak@gentoo.org>,
 Demi Marie Obenour <demi@invisiblethingslab.com>,
 Jan Engelhardt <jengelh@inai.de>,
 "Lyndon Nerenberg (VE7TFX/VE6BBM)" <lyndon@orthanc.ca>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, linux-kernel@vger.kernel.org,
 linux-man@vger.kernel.org
Message-ID: <551c6d28-2b4e-ce4e-7602-29afe014d725@gmail.com>
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
References: <Y6SJDbKBk471KE4k@p183> <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca> <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email> <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email> <20221228192436.viuoyil2ntr4lxjo@mutt-hbsd>
In-Reply-To: <20221228192436.viuoyil2ntr4lxjo@mutt-hbsd>

--------------GxGiU4j9OA3T2C2mhp0X8dga
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpPbiAxMi8yOC8yMiAyMDoyNCwgU2hhd24gV2ViYiB3cm90ZToNCj4gT24g
V2VkLCBEZWMgMjgsIDIwMjIgYXQgMDE6MDI6MzVQTSAtMDUwMCwgRGVtaSBNYXJpZSBPYmVu
b3VyIHdyb3RlOg0KPj4gT24gV2VkLCBEZWMgMjgsIDIwMjIgYXQgMTI6MjU6MTdQTSAtMDUw
MCwgU2hhd24gV2ViYiB3cm90ZToNCj4+PiBPbiBXZWQsIERlYyAyOCwgMjAyMiBhdCAxMTo0
NzoyNUFNIC0wNTAwLCBEZW1pIE1hcmllIE9iZW5vdXIgd3JvdGU6DQo+Pj4+IE9uIFdlZCwg
RGVjIDI4LCAyMDIyIGF0IDEwOjI0OjU4QU0gLTA1MDAsIFNoYXduIFdlYmIgd3JvdGU6DQo+
Pj4+PiBPbiBUdWUsIERlYyAyNywgMjAyMiBhdCAwNDo0NDo0OVBNIC0wODAwLCBMeW5kb24g
TmVyZW5iZXJnIChWRTdURlgvVkU2QkJNKSB3cm90ZToNCj4+Pj4+PiBEb21pbmlxdWUgTWFy
dGluZXQgd3JpdGVzOg0KPj4+Pj4+DQo+Pj4+Pj4+IEJ1dCwgcmVhbGx5LCBJIGp1c3QgZG9u
J3Qgc2VlIGhvdyB0aGlzIGNhbiBwcmFjdGljYWxseSBiZSBzYWlkIHRvIGJlIHBhcnNhYmxl
Li4uDQo+Pj4+Pj4NCj4+Pj4+PiBJbiBpdHMgY3VycmVudCBmb3JtIGl0IG5ldmVyIHdpbGwg
YmUuICBUaGUgc29sdXRpb24gaXMgdG8gcGxhY2UNCj4+Pj4+PiB0aGlzIHZhcmlhYmxlLWxl
bmd0aCBmaWVsZCBsYXN0LiAgVGhlbiB5b3UgY2FuICJjdXQgLWQgJyAnIC1mIDUxLSINCj4+
Pj4+PiB0byBnZXQgdGhlIGNvbW1hbmQrYXJncyBwYXJ0IChhc3N1bWluZyBJIGNvdW50ZWQg
YWxsIHRob3NlIGZpZWxkcw0KPj4+Pj4+IGNvcnJlY3RseSAuLi4pDQo+Pj4+Pj4NCj4+Pj4+
PiBPZiBjb3Vyc2UsIHRoaXMgYnJlYWtzIGJhY2t3YXJkcyBjb21wYXRhYmlsaXR5Lg0KPj4+
Pj4NCj4+Pj4+IEl0IHdvdWxkIGFsc28gYnJlYWsgZm9yd2FyZHMgY29tcGF0aWJpbGl0eSBp
biB0aGUgY2FzZSBuZXcgZmllbGRzDQo+Pj4+PiBuZWVkZWQgdG8gYmUgYWRkZWQuDQo+Pj4+
Pg0KPj4+Pj4gVGhlIG9ubHkgc29sdXRpb24gd291bGQgYmUgYSBsaWJ4by1zdHlsZSBmZWF0
dXJlIHdoZXJlaW4gYQ0KPj4+Pj4gbWFjaGluZS1wYXJzZWFibGUgZm9ybWF0IGlzIGV4cG9z
ZWQgYnkgdmlydHVlIG9mIGEgZmlsZSBleHRlbnNpb24uDQo+Pj4+Pg0KPj4+Pj4gRXhhbXBs
ZXM6DQo+Pj4+Pg0KPj4+Pj4gMS4gL3Byb2MvcGlkL3N0YXRzLmpzb24NCj4+Pj4+IDIuIC9w
cm9jL3BpZC9zdGF0cy54bWwNCj4+Pj4+IDMuIC9wcm9jL3BpZC9zdGF0cy55YW1sX3Nob3Vs
ZG50X2JlX2FfdGhpbmcNCj4+Pj4NCj4+Pj4gQSBiaW5hcnkgZm9ybWF0IHdvdWxkIGJlIGV2
ZW4gYmV0dGVyLiAgTm8gcmlzayBvZiBhbWJpZ3VpdHkuDQo+Pj4NCj4+PiBJIHRoaW5rIHRo
ZSBhcmd1bWVudCBJJ20gdHJ5aW5nIHRvIG1ha2UgaXMgdG8gYmUgZmxleGlibGUgaW4NCj4+
PiBpbXBsZW1lbnRhdGlvbiwgYWxsb3dpbmcgZm9yIGZ1dHVyZSBuZWVkcyBhbmQgd2FudHMt
LXRoYXQgaXMgImZ1dHVyZQ0KPj4+IHByb29maW5nIi4NCj4+DQo+PiBMaW51eCBzaG91bGQg
bm90IGhhdmUgYW4gWE1MLCBKU09OLCBvciBZQU1MIHNlcmlhbGl6ZXIuICBMaW51eCBhbHJl
YWR5DQo+PiBkb2VzIHdheSB0b28gbXVjaDsgbGV04oCZcyBub3QgYWRkIG9uZSBtb3JlIHRo
aW5nIHRvIHRoZSBsaXN0Lg0KPiANCj4gU29tZXdoYXQgYWdyZWVkLiBJIHRoaW5rIGZvcm1h
dHMgbGlrZSBKU09OIHByb3ZpZGUgYSBnb29kIGJhbGFuY2UNCj4gYmV0d2VlbiBtYWNoaW5l
IHBhcnNlYWJsZSBhbmQgaHVtYW4gcmVhZGFibGUuDQo+IGENCj4gQXMgSSBkZXNjcmliZWQg
ZWFybGllciwgdGhvdWdoLCB3aGVuIGl0IGNvbWVzIHRvIGNvbmNlcHRzIGxpa2UgcHJvY2Zz
DQo+IGFuZCBzeXNmcywgSSBoYXZlIGEgYmlhcyB0b3dhcmRzIGFiYW5kb25pbmcgdGhlbSBp
biBmYXZvciBvZiBzeXNjdGwuDQo+IElmIHN5c2N0bCBub2RlcyB3ZXJlIHRvIGJlIHVzZWQs
IG5vIG5ldyBzZXJpYWxpemF0aW9uIGZvcm1hdHMgd291bGQNCj4gbmVlZCB0byBiZSBpbXBs
ZW1lbnRlZC0tYW5kIGRldmVsb3BlcnMgd291bGQgYWxzbyB1c2UgYSBzYWZ0ZXIgbWV0aG9k
DQo+IG9mIHN5c3RlbSBhbmQgcHJvY2VzcyBpbnNwZWN0aW9uIGFuZCBtYW5pcHVsYXRpb24u
DQo+IA0KDQpKdXN0IGEgY29tbWVudCBhcyBzb21lb25lIHdobyBpcyByZWFkaW5nIHdpdGhv
dXQgbXVjaCB1bmRlcnN0YW5kaW5nIG9mIHRoZSANCmNvbnRlbnRzIG9mIC9wcm9kL3BpZC9z
dGF0Og0KDQpJZiBvcmdhbml6YXRpb24gb2YgdGhlIGRhdGEgaW4gdGhlIGZpbGUgaXMgYSBw
cm9ibGVtLCBhbmQgdGhlIGZvcm1hdCBzdGFydHMgdG8gDQptYXR0ZXIsIG1heWJlIGl0J3Mg
YSBoaW50IHRoYXQgdGhlcmUgYXJlIHRvbyBtYW55IGRpZmZlcmVudCBjb250ZW50cywgYW5k
IGNvdWxkIA0KYmUgc3BsaXQgaW50byBkaWZmZXJlbnQgZmlsZXMsIGVhY2ggb25lIHdpdGgg
aXRzIG93biBmb3JtYXR0aW5nIHJ1bGVzLiAgSSdsbCANCnN1Z2dlc3QgdGhhdCBtYXliZSBh
IHNldCBvZiBmaWxlcywgbWF5YmUgY29udGFpbmVkIGluIGEgY29tbW9uIGRpcmVjdG9yeSAN
CnN0YXRzLmQsIGlzIHdoYXQgeW91J3JlIGxvb2tpbmcgZm9yPw0KDQpCaW5hcnkgZm9ybWF0
IGlzIG5vdCBvZiBteSBwcmVmZXJlbmNlLCBzaW5jZSBtb3N0IHVzZXItc3BhY2UgdG9vbHMg
d29yayB3aXRoIHRoZSANCnN0YW5kYXJkIGludGVyZmFjZSwgdGhhdCBpcywgdGV4dC4NCg0K
Q2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIu
ZXMvPg0K

--------------GxGiU4j9OA3T2C2mhp0X8dga--

--------------uQsnnfGhGlsKwv1EyHZlFxph
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmOsn5EACgkQnowa+77/
2zIp/A/+IqPIZTuf0y61jeMBYgI8X43oyFZ3i47GCDW/8EUv7gE5cNN8U4Xqb4xq
UzzItqIluptCq9hHW2vVLjzx47oJ03tLnxK521nRYECItq3XCl1kS4QuNXqcGDFk
tblwxmQCdO2VT2DDVVNe+hF1VlOZF0VAIVQIRQi0XifdQKNZlnnlkMHyaa0llOKu
Jwiq2ZD3cJGrkr6UlqOCT+DySZXceHOApr7CfXnDax5v3CNpF3Ho+yMZ7xmZbPKs
BSBJ0JtBmF5F67yhGlvwThNqO0NqqQ553ftdx/20LL3zR0ihcwQIKzQor0xiLNIM
W+GUiawt7UjGTDQwP/LWBmXTFTy0RRhy7PWFmAnWwFMvGLQtN4vy5Hswzu5xWT21
pAhy1Pl+ApqI/YngDyiKoRVSt/VGCWIX3WSJG46M7+QGlYCfa0c1IaZUemJv3WEF
EjOwwFrBSh+Alst7RChZQbEJnPAcTEONZnrFFViteSGmcOtPygYZPHc4ES02BKcd
VF/1Iwqlu5G7ZyDegmKiJB6am6yN3UQJk57e37/iWQaHHZXTuqlxW/clxVoIj1R3
OlvInEgS9/KFSXHGJeZGa+Gnwqe4D9clgv4xSnWqVTq6Ltu4MxNAXXEHhYZ6Qoq6
ybg4PWdzpUXnekude4aZd2HAiCsONO5A4exttpbTRUcdqIQC8kg=
=+Hm7
-----END PGP SIGNATURE-----

--------------uQsnnfGhGlsKwv1EyHZlFxph--
