Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B66546C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiLVTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:39:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1CC1D5;
        Thu, 22 Dec 2022 11:39:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l26so606002wme.5;
        Thu, 22 Dec 2022 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9cNZ+Bf8XkMdgaZydY+Q/7bfIxwniBzYP/iKeBix+UA=;
        b=pbNMWUlXNFQqOse0E3lAV5UTG0e2D3tY2L4/q1dQTkpjdNfoZruQhvq9g8c7+xEZT4
         YE7ekoHx9mVOZQmDkj2LtdOmrR6nkPq6OCJVM3hZoX6wIdZkHNN3XcgYqZ1ZeFu4QirT
         8UvcljFfIW4G/beODs2DUjpC7a71mg6kEwHmk5qCvz2LI4Ju4TpvhpgyyQk/nz6Sn8Uf
         B6NGfTObau3KKNihMFL1AbqVc3cLQxyQozCGVZSsZQV8Rw/dpFsvHC0jiJt8Z+I65/53
         abDFgNhQbQ4KOMjHOtGs5FST/H3efOox91ehNrKiapN0t3J2j3nSlcH6z8VhORINab+k
         PnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cNZ+Bf8XkMdgaZydY+Q/7bfIxwniBzYP/iKeBix+UA=;
        b=O8Ymn7sQnBV43l/zxdrc46BYLK+yuDfpL2PqsBp1tuDo/qL/VZHDvBY3KqXcwfdE3O
         8OBwknJ1R1wAgom5ygGkUbg2pz6Nj8Dd3Ry4TvdGUWwR+sdyxvxSHe+ejLXtMmewHgjT
         p2zKwqlL+VzFQTtuC21nwE0FwMVaoq3NUHRjW5Nfqlz5Gtm4IZJf1FUdfqYe2qddMpVW
         1CF5HSYfT2q46IIT7siUvsxsMdsSF4t6yeiXkSg9KhGR9J1lrl1RAsIswZwUCiLLYCY9
         qqWrwR5TRCwA5HlxEfdHTECGvEFKx1NmFK/b7Njb661thDrZgYrrYuEdQ9lSzXFwEPCO
         NtPA==
X-Gm-Message-State: AFqh2koVDo5u3oO+i7NaTYZ5Dh85MJoqemkAsXHp2ga1f4jM/8be5ROy
        4kMMGpzwFS6mkDJc70mR830m6pWKSxs=
X-Google-Smtp-Source: AMrXdXsN6oUO4aJ/5wkC/J2SLZM2mhpd7uFnfkocFcMgcfbaMW22isDWCCH/av63/XsQsN3y0MwxcQ==
X-Received: by 2002:a05:600c:1da3:b0:3d2:1761:3742 with SMTP id p35-20020a05600c1da300b003d217613742mr5333706wms.15.1671737950434;
        Thu, 22 Dec 2022 11:39:10 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003d355ad9bb7sm7472427wmq.20.2022.12.22.11.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:39:09 -0800 (PST)
Message-ID: <4b2d7cd7-da3e-9bd7-ef69-f59635ed1f69@gmail.com>
Date:   Thu, 22 Dec 2022 20:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-man <linux-man@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        groff <groff@gnu.org>, Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Sam James <sam@gentoo.org>,
        Marcos Fouces <marcos@debian.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: man-pages-6.02 released
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3UPBRzLAHXpYPlbpL4qhqwQM"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3UPBRzLAHXpYPlbpL4qhqwQM
Content-Type: multipart/mixed; boundary="------------ZxToELi97HZ8nF5LklQs2NZD";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: linux-man <linux-man@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GNU C Library <libc-alpha@sourceware.org>, groff <groff@gnu.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Sam James <sam@gentoo.org>, Marcos Fouces <marcos@debian.org>
Message-ID: <4b2d7cd7-da3e-9bd7-ef69-f59635ed1f69@gmail.com>
Subject: man-pages-6.02 released

--------------ZxToELi97HZ8nF5LklQs2NZD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

R2lkZGF5IQ0KDQpJJ20gcHJvdWQgdG8gYW5ub3VuY2U6DQoNCgltYW4tcGFnZXMtNi4wMiAt
IG1hbnVhbCBwYWdlcyBmb3IgR05VL0xpbnV4DQoNClRoZSByZWxlYXNlIHRhcmJhbGwgaXMg
YWxyZWFkeSBhdmFpbGFibGUgb24gPGtlcm5lbC5vcmc+Lg0KDQpUYXJiYWxsIGRvd25sb2Fk
Og0KICAgICAgPGh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5lbC5vcmcvcHViL2xpbnV4L2Rv
Y3MvbWFuLXBhZ2VzLz4NCkdpdCByZXBvc2l0b3J5Og0KICAgICAgPGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvY2dpdC9kb2NzL21hbi1wYWdlcy9tYW4tcGFnZXMuZ2l0Lz4NCg0KVGhlIG1v
c3Qgbm90YWJsZSBjaGFuZ2VzIGluIHRoaXMgcmVsZWFzZSBhcmUgdGhlIGZvbGxvd2luZzoN
Cg0KLSAgUmV3cml0dGVuIHBhZ2VzIGZvciBzdHJpbmctY29weWluZyBmdW5jdGlvbnMuICBU
aGVzZSBub3cgdXNlDQogICAgY29uc2lzdGVudCBsYW5ndWFnZS4gIEFsc28gYWRkZWQgYSBu
ZXcgc3RyaW5nX2NvcHlpbmcoNykgcGFnZSB0aGF0DQogICAgc2VydmVzIGFzIGFuIG92ZXJ2
aWV3IG9mIGFsbCBzdWNoIGZ1bmN0aW9ucywgY29tcGFyZXMgdGhlbSwgYW5kDQogICAgZGV0
YWlscyB3aGljaCBpcyBhcHByb3ByaWF0ZSBmb3Igd2hpY2ggdXNlcy4NCg0KLSAgVXNlIF9O
dWxsYWJsZSBmb3IgZG9jdW1lbnRpbmcgd2hpY2ggZnVuY3Rpb25zIGFjY2VwdCBOVUxMIGFz
IGENCiAgICBtZWFuaW5nZnVsIHZhbHVlIGluIHRoZSBmdW5jdGlvbiBwcm90b3R5cGVzIGlu
IHRoZSBTWU5PUFNJUy4NCg0KLSAgVXNlIFZMQSBzeW50YXggZm9yIGRvY3VtZW50aW5nIGZ1
bmN0aW9uIHBhcmFtZXRlcnMgdGhhdCBhcmUgdHJlYXRlZA0KICAgIGFzIGFycmF5cy4gIFRo
aXMgdXNlcyBzeW50YXggbm90IGFjY2VwdGVkIGJ5IGNvbXBpbGVycy4NCg0KLSAgUmV3cml0
dGVuIHJlcG9zaXRvcnkgZG9jdW1lbnRhdGlvbiAoUkVBRE1FLCBDT05UUklCVVRJTkcsIElO
U1RBTEwsIC4uLikuDQoNCi0gIERvY3VtZW50YXRpb24gZm9yIG5ldyBBUElzLCBzdWNoIGFz
IE1BRFZfQ09MTEFQU0UgaW4gbWFkdmlzZSgyKS4NCg0KVGhhbmsgeW91IGFsbCBmb3IgY29u
dHJpYnV0aW5nLg0KDQotICBUaGVyZSdzIGFsc28gYSByZXBvc2l0b3J5IGNoYW5nZSB0aGF0
IGlzIG5vdCBwYXJ0IG9mIHRoaXMgcmVsZWFzZTogIEhpc3RvcmljIA0KdmVyc2lvbnMgb2Yg
dGhlIHByb2plY3QgZ29pbmcgYmFjayB0byBtYW4tcGFnZXMtMS4wIGhhdmUgYmVlbiBhZGRl
ZCB0byB0aGUgZ2l0IA0KcmVwb3NpdG9yeSBpbiBhICdwcmVoaXN0b3J5JyBicmFuY2guDQoN
CkNoZWVycywNCg0KQWxleA0KDQo9PT09PT09PT09PT09PT09PT09PSBDaGFuZ2VzIGluIG1h
bi1wYWdlcy02LjAyID09PT09PT09PT09PT09PT09PT09DQoNClJlbGVhc2VkOiAyMDIyLTEy
LTIyLCBBbGRheWENCg0KDQpDb250cmlidXRvcnMNCi0tLS0tLS0tLS0tLQ0KDQpUaGUgZm9s
bG93aW5nIHBlb3BsZSBjb250cmlidXRlZCBwYXRjaGVzL2ZpeGVzLCByZXBvcnRzLCBub3Rl
cywNCmlkZWFzLCBhbmQgZGlzY3Vzc2lvbnMgdGhhdCBoYXZlIGJlZW4gaW5jb3Jwb3JhdGVk
IGluIGNoYW5nZXMgaW4NCnRoaXMgcmVsZWFzZToNCg0KDQoiRy4gQnJhbmRlbiBSb2JpbnNv
biIgPGcuYnJhbmRlbi5yb2JpbnNvbkBnbWFpbC5jb20+DQoxMDkyNjE1MDc5IDwxMDkyNjE1
MDc5QHFxLmNvbT4NCkFhcm9uIFNjaHJhYiA8YWFyb25Ac2NocmFiLmNvbT4NCkFnb3N0aW5v
IFNhcnViYm8gPGFnb0BnZW50b28ub3JnPg0KQWhlbGVuaWEgWmllbWlhxYRza2EgPG5hYmlq
YWN6bGV3ZWxpQG5hYmlqYWN6bGV3ZWxpLnh5ej4NCkFsZWphbmRybyBDb2xvbWFyIDxhbHhA
a2VybmVsLm9yZz4NCkFsZXggQ29sb21hciA8YWx4Lm1hbnBhZ2VzQGdtYWlsLmNvbT4NCkFt
aXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQpBbmRyZXcgQ2xheXRvbiA8YW5k
cmV3QGRpZ2l0YWwtZG9tYWluLm5ldD4NCkFuZHJldyBQaW5za2kgPHBpbnNraWFAZ21haWwu
Y29tPg0KQW5kcmllcyBFLiBCcm91d2VyIDxhZWJAY3dpLm5sPg0KRGFycmljayBKLiBXb25n
IDxkandvbmdAa2VybmVsLm9yZz4NCkRvdWdsYXMgTWNJbHJveSA8ZG91Z2xhcy5tY2lscm95
QGRhcnRtb3V0aC5lZHU+DQpFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQpG
bG9yaWFuIFdlaW1lciA8ZndlaW1lckByZWRoYXQuY29tPg0KRy4gQnJhbmRlbiBSb2JpbnNv
biA8Zy5icmFuZGVuLnJvYmluc29uQGdtYWlsLmNvbT4NCkdyaWdvcml5IDxncmlnb3JpeXJl
bXZhckBwcm90b25tYWlsLmNvbT4NCkdyemVnb3J6IFN6eW1hc3playA8Z3N6eW1hc3pla0Bz
aG9ydC5wbD4NCkhlbGdlIEtyZXV0em1hbm4gPGRlYmlhbkBoZWxnZWZqZWxsLmRlPg0KSWFu
IEFiYm90dCA8YWJib3R0aUBtZXYuY28udWs+DQpJa2VyIFBlZHJvc2EgPGlwZWRyb3NhQHJl
ZGhhdC5jb20+DQpJbmdvIFNjaHdhcnplIDxzY2h3YXJ6ZUBvcGVuYnNkLm9yZz4NCkpha3Vi
IFdpbGsgPGp3aWxrQGp3aWxrLm5ldD4NCkphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQpKZWFu
SGV5ZCBNZW5laWRlIDx3ZzE0QHNvYXNpcy5vcmc+DQpKdW4gSXNoaWd1cm8gPGFsZ29uLjAz
MjBAZ21haWwuY29tPg0KTHVjYSBWZXJzYXJpIDx2ZWx1Y2E5M0BnbWFpbC5jb20+DQpMdWlz
IEphdmllciBNZXJpbm8gPG5pbmphbGpAZ21haWwuY29tPg0KTWFyaW8gQmzDpHR0ZXJtYW5u
IDxtYXJpby5ibGFldHRlcm1hbm5AZ21haWwuY29tPg0KTWFydGluIFNlYm9yIDxtc2Vib3JA
cmVkaGF0LmNvbT4NCk1hcnRpbiBVZWNrZXIgPHVlY2tlckB0dWdyYXouYXQ+DQpNYXR0aGV3
IEJvYnJvd3NraSA8cmVwbm9wQGdvb2dsZS5jb20+DQpNaWNoYWVsIEtlcnJpc2sgPG10ay5t
YW5wYWdlc0BnbWFpbC5jb20+DQpNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1Pg0K
TWlrZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPg0KTWlrZSBHaWxiZXJ0IDxmbG9w
cHltQGdlbnRvby5vcmc+DQpNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPg0KTmlj
b2zDoXMgQS4gT3J0ZWdhIEZyb3lzYSA8bmljb2xhc0BvcnRlZ2FzLm9yZz4NClBhbGkgUm9o
w6FyIDxwYWxpQGtlcm5lbC5vcmc+DQpQaWVycmUgTGFiYXN0aWUgPHBpZXJyZS5sYWJhc3Rp
ZUBuZXVmLmZyPg0KU2FtIEphbWVzIDxzYW1AZ2VudG9vLm9yZz4NClNlcmdlIEhhbGx5biA8
c2VyZ2VAaGFsbHluLmNvbT4NClN0ZWZhbiBQdWl1IDxzdGVmYW4ucHVpdUBnbWFpbC5jb20+
DQpTdGV2ZSBJem1hIDxzaXptYUBnb2xkZW4ubmV0Pg0KU3VyZW4gQmFnaGRhc2FyeWFuIDxz
dXJlbmJAZ29vZ2xlLmNvbT4NClRob21hcyBWb3NzIDxtYWlsQHRob21hc3Zvc3MuY29tPg0K
VHljaG8gQW5kZXJzZW4gPHR5Y2hvQHR5Y2hvLnBpenphPg0KWGkgUnVveWFvIDx4cnkxMTFA
eHJ5MTExLnNpdGU+DQpaYWNoIE8nS2VlZmUgPHpva2VlZmVAZ29vZ2xlLmNvbT4NClphY2sg
V2VpbmJlcmcgPHphY2tAb3dsZm9saW8ub3JnPg0KDQoNCkFwb2xvZ2llcyBpZiBJIG1pc3Nl
ZCBhbnlvbmUhDQoNCg0KTmV3IGFuZCByZXdyaXR0ZW4gcGFnZXMNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoNCm1hbjMvDQoJc3RhdGljX2Fzc2VydC4zDQoJc3RyY3B5LjMNCglzdHBu
Y3B5LjMNCglzdHJuY2F0LjMNCg0KbWFuM2NvbnN0Lw0KCUVPRi4zY29uc3QNCglFWElUX1NV
Q0NFU1MuM2NvbnN0DQoNCm1hbjcvDQoJc3RyaW5nX2NvcHlpbmcuNw0KDQoNCk5ld2x5IGRv
Y3VtZW50ZWQgaW50ZXJmYWNlcyBpbiBleGlzdGluZyBwYWdlcw0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCmlvY3RsX3R0eS4yDQoJVElPQ1NF
UkdFVExTUg0KCVRJT0NTRVJfVEVNVA0KDQptYWR2aXNlLjINCglNQURWX0NPTExBUFNFDQoN
CnN5c2NhbGwuMg0KCWxvb25nYXJjaA0KDQoNCk5ldyBhbmQgY2hhbmdlZCBsaW5rcw0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQoNCm1hbjMvDQoJX1N0YXRpY19hc3NlcnQuMwkoc3RhdGlj
X2Fzc2VydCgzKSkNCglzdHBjcHkuMwkJKHN0cmNweSgzKSkNCglzdHJjYXQuMwkJKHN0cmNw
eSgzKSkNCglzdHJuY3B5LjMJCShzdHBuY3B5KDMpKQ0KCXN0cGVjcHkuMwkJKHN0cmluZ19j
b3B5aW5nKDcpKQ0KCXN0cGVjcHl4LjMJCShzdHJpbmdfY29weWluZyg3KSkNCgl1c3RwY3B5
LjMJCShzdHJpbmdfY29weWluZyg3KSkNCgl1c3RyMnN0cC4zCQkoc3RyaW5nX2NvcHlpbmco
NykpDQoJenVzdHIyc3RwLjMJCShzdHJpbmdfY29weWluZyg3KSkNCgl6dXN0cjJ1c3RwLjMJ
CShzdHJpbmdfY29weWluZyg3KSkNCg0KbWFuM2NvbnN0Lw0KCUVYSVRfRkFJTFVSRS4zY29u
c3QJKEVYSVRfU1VDQ0VTUygzY29uc3QpKQ0KDQoNCkdsb2JhbCBjaGFuZ2VzDQotLS0tLS0t
LS0tLS0tLQ0KDQotICBVc2UgY29ycmVjdCBsZXR0ZXIgY2FzZSBpbiBtYW51YWwgcGFnZSB0
aXRsZXMsIGluc3RlYWQgb2YgdXBwZXJjYXNlLg0KDQotICBVc2UgXCIgdCBjb21tZW50cyB3
aGVuIGFwcHJvcHJpYXRlIChMaW50aWFuIG5lZWRzIHRoaXMpLg0KDQotICBTWU5PUFNJUzoN
Cg0KICAgIC0gIEFkZCBfTnVsbGFibGUgZm9yIGZ1bmN0aW9ucyB0aGF0IHJlY2VpdmUgTlVM
TCBhcyBhIG1lYW5pbmdmdWwNCiAgICAgICBpbnB1dC4NCg0KICAgIC0gIFVzZSBWTEEgc3lu
dGF4IHRvIGNsYXJpZnkgdGhlIG1lYW5pbmcgb2Ygc2l6ZSBwYXJhbWV0ZXJzLCByYXRoZXIN
CiAgICAgICB0aGFuIGhpZGluZyBpdCBpbiBwb3NzaWJseS1jb25mdXNpbmcgdGV4dC4gIFRo
aXMgc3ludGF4IGlzIG5vdA0KICAgICAgIGFjY2VwdGVkIGJ5IGFueSBjb21waWxlcnMsIHRo
b3VnaC4NCg0KICAgIC0gIFVzZSBbW25vcmV0dXJuXV0gaW5zdGVhZCBvZiBub3JldHVybiwg
d2hpY2ggd2lsbCBiZSBkZXByZWNhdGVkDQogICAgICAgc29vbi4NCg0KLSAgUmVwb3NpdG9y
eSBkb2N1bWVudGF0aW9uOg0KDQogICAgLSAgQWRkZWQgc2lnbmlmaWNhbnQgZG9jdW1lbnRh
dGlvbiBhYm91dCB0aGUgcmVwb3NpdG9yeSBhbmQgdGhlDQogICAgICAgcHJvamVjdCBpbiB0
aGUgcm9vdCBvZiB0aGUgcmVwb3NpdG9yeSBpbiBkaWZmZXJlbnQgZmlsZXMuDQogICAgICAg
U3RhcnRpbmcgZnJvbSB0aGUgUkVBRE1FLCBhbnlvbmUgcGFzc2luZyBieSBzaG91bGQgYmUg
YWJsZSB0bw0KICAgICAgIHVuZGVyc3RhbmQgaG93IHRoZSBwcm9qZWN0IHdvcmtzIGFuZCBi
ZSBkaXJlY3RlZCB0byBvdGhlcg0KICAgICAgIGRvY3VtZW50YXRpb24gZmlsZXMuICBUaGVz
ZSBmaWxlcyBhbHNvIGRvY3VtZW50IHRoZSByZWxlYXNlDQogICAgICAgcHJvY2Vzcy4NCg0K
ICAgIC0gIE1pY2hhZWwgaGFzIGJlZW4gYnVzeSBsYXRlbHksIGFuZCBoZSBpcyBubyBsb25n
ZXIgbWFpbnRhaW5pbmcNCiAgICAgICB0aGUgcHJvamVjdC4gIFRoZSBpbi1yZXBvc2l0b3J5
IGRvY3VtZW50YXRpb24gbWVudGlvbmVkIGFib3ZlIGhhcw0KICAgICAgIGJlZW4gdXBkYXRl
ZCB0byByZWZsZWN0IHRoYXQuDQoNCg0KQ2hhbmdlcyB0byBpbmRpdmlkdWFsIHBhZ2VzDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KY29weV9maWxlX3JhbmdlLjINCglGaXgg
d3Jvbmcga2VybmVsIHZlcnNpb24gaW5mb3JtYXRpb24NCg0KcHJvY2Vzc19tYWR2aXNlLjIN
CglGaXggY2FwYWJpbGl0eSBhbmQgcHRyYWNlIHJlcXVpcmVtZW50cw0KDQptYWR2aXNlLjIN
CglVcGRhdGUgVHJhbnNwYXJlbnQgSHVnZSBQYWdlcyBmaWxlL3NobWVtIGRvY3VtZW50YXRp
b24gZm9yDQoJTGludXggNS40Ky4NCg0KDQpUaGUgbWFudWFsIHBhZ2VzIChhbmQgb3RoZXIg
ZmlsZXMgaW4gdGhlIHJlcG9zaXRvcnkpIGhhdmUgYmVlbiBpbXByb3ZlZA0KYmV5b25kIHdo
YXQgdGhpcyBjaGFuZ2Vsb2cgY292ZXJzLiAgVG8gbGVhcm4gbW9yZSBhYm91dCBjaGFuZ2Vz
IGFwcGxpZWQNCnRvIGluZGl2aWR1YWwgcGFnZXMsIHVzZSBnaXQoMSkuDQoNCg0KLS0gDQo8
aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------ZxToELi97HZ8nF5LklQs2NZD--

--------------3UPBRzLAHXpYPlbpL4qhqwQM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmOkslwACgkQnowa+77/
2zJsrRAAonL4nmoZUeQjwONic2XjHtqyrPk0MFXElz1o5sMiEzNSzd63dJSBnJ+p
3RczdZ9wbaMX6XqJlOSwwtS7XsUgRqudjsM3P9RZ4VLgvXsuCPeK7qi0ua1vejEa
hFEAIT8u62UyEX2wRZi8qXySrBQGV/eSuU0esTUesJhsQlh9pUyPlXW12p6yd7iV
9Q7YLnQXA3grz8vClXJShwoQSkLGBzI6/iRHTAtlCHe6pWYzfLPCEBgopVkjqpQO
eJzpzDHRubXYC6xTkcRrmXqJnsvpFzTfR4aqQZrnAzzxznJAQXKCJaXu3pTZPt6Y
FZaw7WqkFlmE9o36PV2EpTDt0C6k0zybS/9skm2tsaIFrrcOj6yogyz3tRO+Uu8F
2E7B5nBU0FXxfm8wmJ7jI30g+Sx2Y2kIef6VTChmSHpDYbRqcsAVb74S028gnPu+
UBOerkP/HuxAH8hjH+P8NF6+09Av9BmBrb5UCpjQwFpog4v5i5I1oQIWilxWvfFt
nUD1zlL6iR7kmn2uqdG6tS2rkpElOe4DJnjeZE61MvdhHxABCqaEyFXwfSMUaoka
EUQEbELzbAPvsRm75JRmPj9puNi9Seiw5asf3K+RQ/pEruf5LZciyKguzONeGi0K
TSwFsnc6cz6QhGwE64aByb9BxUcprKCP4/q3cqxvNKwNM0jRjak=
=y6Id
-----END PGP SIGNATURE-----

--------------3UPBRzLAHXpYPlbpL4qhqwQM--
