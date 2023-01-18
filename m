Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB048671160
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjARCzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARCzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:55:17 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EBF4FCDB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:55:16 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id NTV00108;
        Wed, 18 Jan 2023 10:55:08 +0800
Received: from jtjnmail201619.home.langchao.com (10.100.2.19) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 10:55:11 +0800
Received: from jtjnmail201619.home.langchao.com ([fe80::c426:eceb:41d0:3372])
 by jtjnmail201619.home.langchao.com ([fe80::c426:eceb:41d0:3372%2]) with mapi
 id 15.01.2507.016; Wed, 18 Jan 2023 10:55:11 +0800
From:   =?utf-8?B?dG9tb3Jyb3cgV2FuZyAo546L5b635piOKQ==?= 
        <wangdeming@inspur.com>
To:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tL2hpZ2htZW06IGZpeCBzcGVsbGluZyBtaXN0?=
 =?utf-8?Q?akeo?=
Thread-Topic: [PATCH] mm/highmem: fix spelling mistakeo
Thread-Index: AQHZKtX2S07VtuXrCUm9LbcMY04Ug66i61iAgACL53A=
Date:   Wed, 18 Jan 2023 02:55:11 +0000
Message-ID: <67e5d78c78824176847cc5bb5798e12f@inspur.com>
References: <63c9e0aaf682ab012d27dced94d127b818-1-23gmail.com@g.corp-email.com>
 <Y8dXpe5CCo5Kl3Zg@debian.me>
In-Reply-To: <Y8dXpe5CCo5Kl3Zg@debian.me>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.104.82]
Content-Type: multipart/signed; micalg=SHA1;
        protocol="application/x-pkcs7-signature";
        boundary="----=_NextPart_000_0042_01D92B2A.1A6B9820"
MIME-Version: 1.0
tUid:   2023118105508e58b7dfe298cba3860f53a603f45f47e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_NextPart_000_0042_01D92B2A.1A6B9820
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0043_01D92B2A.1A6B9820"


------=_NextPart_001_0043_01D92B2A.1A6B9820
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

 I find only one typo about higmem. And I have modified the subject.

Thanks

> send: Bagas Sanjaya <bagasdotme@gmail.com>
> time: 2023=E5=B9=B41=E6=9C=8818=E6=97=A5 10:21
> to: tomorrow Wang (=E7=8E=8B=E5=BE=B7=E6=98=8E) =
<wangdeming@inspur.com>;
> corbet@lwn.net; fmdefrancesco@gmail.com; akpm@linux-foundation.org;
> bigeasy@linutronix.de; ira.weiny@intel.com; rppt@kernel.org
> subject: Re: [PATCH] mm/highmem: fix spelling mistakeo
>=20
> On Tue, Jan 17, 2023 at 07:43:56PM -0500, Deming Wang wrote:
> > Substitute occurrencies of "higmem" with "highmem".
> >
> > Signed-off-by: Deming Wang <wangdeming@inspur.com>
> > ---
> >  Documentation/mm/highmem.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/mm/highmem.rst
> > b/Documentation/mm/highmem.rst index 59d1078f53df..7da4a0d175f0
> 100644
> > --- a/Documentation/mm/highmem.rst
> > +++ b/Documentation/mm/highmem.rst
> > @@ -83,7 +83,7 @@ list shows them in order of preference of use.
> >    for pages which are known to not come from ZONE_HIGHMEM. However,
> it is
> >    always safe to use kmap_local_page() / kunmap_local().
> >
> > -  While it is significantly faster than kmap(), for the higmem case
> > it
> > +  While it is significantly faster than kmap(), for the highmem =
case
> > + it
> >    comes with restrictions about the pointers validity. Contrary to =
kmap()
> >    mappings, the local mappings are only valid in the context of the =
caller
> >    and cannot be handed to other contexts. This implies that users
> > must
>=20
> Are you sure you have seen the other occurences of higmem in the same =
doc?
> If so, do s/higmem/highmem/g.
>=20
> Also, the patch subject prefix should have been Documentation: mm:
> highmem, and also s/mistakeo/mistake/ in the subject.
>=20
> Thanks.
>=20
> --
> An old man doll... just what I always wanted! - Clara

------=_NextPart_001_0043_01D92B2A.1A6B9820
Content-Type: application/octet-stream;
	name="0001-Documentation-mm-use-s-higmem-highmem-fix-typo-for-h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Documentation-mm-use-s-higmem-highmem-fix-typo-for-h.patch"

From 97b1ab6a569d7517819f9deff63ec3e7c96879c7 Mon Sep 17 00:00:00 2001=0A=
From: Deming Wang <wangdeming@inspur.com>=0A=
Date: Wed, 18 Jan 2023 10:27:03 +0800=0A=
Subject: [PATCH] Documentation: mm: use `s/higmem/highmem/` fix typo for=0A=
 highmem=0A=
=0A=
We should use highmem replace higmem.=0A=
=0A=
Signed-off-by: Deming Wang <wangdeming@inspur.com>=0A=
---=0A=
 Documentation/mm/highmem.rst | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst=0A=
index 59d1078f53df..7da4a0d175f0 100644=0A=
--- a/Documentation/mm/highmem.rst=0A=
+++ b/Documentation/mm/highmem.rst=0A=
@@ -83,7 +83,7 @@ list shows them in order of preference of use.=0A=
   for pages which are known to not come from ZONE_HIGHMEM. However, it =
is=0A=
   always safe to use kmap_local_page() / kunmap_local().=0A=
 =0A=
-  While it is significantly faster than kmap(), for the higmem case it=0A=
+  While it is significantly faster than kmap(), for the highmem case it=0A=
   comes with restrictions about the pointers validity. Contrary to =
kmap()=0A=
   mappings, the local mappings are only valid in the context of the =
caller=0A=
   and cannot be handed to other contexts. This implies that users must=0A=
-- =0A=
2.27.0=0A=
=0A=

------=_NextPart_001_0043_01D92B2A.1A6B9820--

------=_NextPart_000_0042_01D92B2A.1A6B9820
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIK8zCCA6Iw
ggKKoAMCAQICEGPKUixTOHaaTcIS5DrQVuowDQYJKoZIhvcNAQELBQAwWTETMBEGCgmSJomT8ixk
ARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTES
MBAGA1UEAxMJSU5TUFVSLUNBMB4XDTE3MDEwOTA5MjgzMFoXDTI3MDEwOTA5MzgyOVowWTETMBEG
CgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQB
GRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAq+Q17xtjJLyp5hgXDie1r4DeNj76VUvbZNSywWU5zhx+e0Lu0kwcZ0T3KncZdgdWyqYvRJMQ
/VVqX3gS4VxtLw3zBrg9kGuD0LfpH0cA2b0ZHpxRh5WapP14flcSh/lnawig29z44wfUEg43yTZO
lOfPKos/Dm6wyrJtaPmD6AF7w4+vFZH0zMYfjQkSN/xGgS3OPBNAB8PTHM2sV+fFmnnlTFpyRg0O
IIA2foALZvjIjNdUfp8kMGSh/ZVMfHqTH4eo+FcZPZ+t9nTaJQz9cSylw36+Ig6FGZHA/Zq+0fYy
VCxR1ZLULGS6wsVep8j075zlSinrVpMadguOcArThwIDAQABo2YwZDATBgkrBgEEAYI3FAIEBh4E
AEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUXlkDprRMWGCRTvYe
taU5pjLBNWowEAYJKwYBBAGCNxUBBAMCAQAwDQYJKoZIhvcNAQELBQADggEBAErE37vtdSu2iYVX
Fvmrg5Ce4Y5NyEyvaTh5rTGt/CeDjuFS5kwYpHVLt3UFYJxLPTlAuBKNBwJuQTDXpnEOkBjTwukC
0VZ402ag3bvF/AQ81FVycKZ6ts8cAzd2GOjRrQylYBwZb/H3iTfEsAf5rD/eYFBNS6a4cJ27OQ3s
Y4N3ZyCXVRlogsH+dXV8Nn68BsHoY76TvgWbaxVsIeprTdSZUzNCscb5rx46q+fnE0FeHK01iiKA
xliHryDoksuCJoHhKYxQTuS82A9r5EGALTdmRxhSLL/kvr2M3n3WZmVL6UulBFsNSKJXuIzTe2+D
mMr5DYcsm0ZfNbDOAVrLPnUwggdJMIIGMaADAgECAhN+AADW2NzeiRillYrtAAAAANbYMA0GCSqG
SIb3DQEBCwUAMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hh
bzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQTAeFw0yMDA4MDYxMTEz
MzdaFw0yNTA4MDUxMTEzMzdaMIGfMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQB
GRYIbGFuZ2NoYW8xFDASBgoJkiaJk/IsZAEZFgRob21lMR4wHAYDVQQLDBXkupHmlbDmja7kuK3l
v4Ppm4blm6IxEjAQBgNVBAMMCeeOi+W+t+aYjjEkMCIGCSqGSIb3DQEJARYVd2FuZ2RlbWluZ0Bp
bnNwdXIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2vlBZLJq8TGM+29yQN3P
JA6nQmkd95s06bHPiYoLyRo1s8ow3GEo+AXrGTrvfAQSqDuM20xwoTdNxaxzHw73OT/a1WaBGZBG
LSExU/PwnxpYNWy6VEkOEMgLzb790SRCsJ+tg9JDYzSoQYx2nxVI6qoR4lEOeQcwGkgO76IsJrEk
L4/i9bgkH8SGGN8OCIG8OyKag4j12raDfKEV4B1g+RhQqPua6orrK30akBWSL0P1anheVOlWDrqy
osJcF64HTzmDyqPLMzISF69XMhCfmxyaKSkLbFLmNE0eEZVJsdhGyV4e0qAx3kpqeTThtzOYMwkT
oiUcyhkbr/tlBqNlwQIDAQABo4IDwTCCA70wPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgvKp
H4SB13qGqZE9hoD3FYPYj1yBSv2LJoGUp00CAWQCAWAwKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEMAsGA1UdDwQEAwIFoDA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUF
BwMCMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0D
AgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1UdDgQWBBT2m8+B
pv3zOH+FCDvTbpfMkvPbAzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1ajCCAQ8GA1Ud
HwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRDQTIwMTIsQ049
Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
b24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9i
YXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRDQTIwMTIuaG9t
ZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYBBQUHAQEEggEb
MIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEsQ049UHVibGlj
JTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1ob21lLERD
PWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNh
dGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8u
Y29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVSLUNBLmNydDBH
BgNVHREEQDA+oCUGCisGAQQBgjcUAgOgFwwVd2FuZ2RlbWluZ0BpbnNwdXIuY29tgRV3YW5nZGVt
aW5nQGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBAKD6Oh0Yu1g2xXDIaczYlx8WZiYqTi7t
bFCmsNT5DmNUfLaJre5UDyaWjgwW6Z/KN1X19Piy6oS8ex93gaeF4siDuQimREZoKxePJyUeyFs5
oC6kpsw95f/0RM5zhHb4I8L4AgplfwySCGAeMRr74rThzkYWfoU1AM+c8cBtViIispknx6KxJFo2
b533lCx168UKeNRb1n7pUANxFYd+1jjdRKCPrszdJcJddFmnLBetcnD4DG0ID62hnw+/g0KoAlfd
ORikFVBLobsDNy+NQ++5ZYgx1ahEQ6BESIjeWxut+2Zqis6Zbwd5ZsBhm892l5EdzJCuYe5xDEZw
0Z0bGvUxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZ
FghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA
1tjc3okYpZWK7QAAAADW2DAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTgwMjQ2MjFaMCMGCSqGSIb3DQEJBDEWBBTzog/QRR4dGRfS
/FdoPJlnfXnA8DB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJ
kiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BV
Ui1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJkiaJ
k/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhv
bWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA1tjc3okYpZWK7QAAAADW2DCBkwYJKoZIhvcNAQkP
MYGFMIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC6nSCjB3JV8ZTIQlLCP9XW
8LZUBCycSXooiorHKHxCOxD78Yk5jCG7VRUtsKnIvTKLEJeB1PJfTM3OXFdvjjLjjrrNPgKkxGiS
l2qJY9oK1Qgcg5n1geVbk8wqTLSmMjMDSiL9M+rb3ggrAKhsI7WX1CyoZE2WdzpyT6rL5fi6COHb
wgcW9Ml8Th5WzkTkaryb6cS5OqCK811/sGb+40uqKl5mVqQ1dkvMoyyN/mjSFCsOqRNA2D3Z4ljX
3lpj3Vvmb0FvbV0xunAEAPYuhayi/su3SFAPYqynseA0+aRAqYI7UK80WGZieJ9qXbKyvtqBObMM
0eDS1vjbF+oazG7dAAAAAAAA

------=_NextPart_000_0042_01D92B2A.1A6B9820--
