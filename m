Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043BC5B84CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiINJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:17:49 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442577556;
        Wed, 14 Sep 2022 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1663146484; x=1694682484;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3DNQqdln3Py7csMXE0mynMir2rNmfZO/eILyH+2VOHs=;
  b=naSgFqQjOc8MIEUVPW6LlCjCBG/8W0FgLf5U2u4xSNBQD5m5qIOfYSg7
   P7PrD4Rq0y5QpjANqce+Z8lWsxXfq7+OJtfO3lC+c6I7l1wM0gpFVBzmy
   iP5+zbzEUIjQP94jooj9mKPPvYH8SAHctGWtAAPq5SNVcsuoS8wT+0I2m
   6bEGX4DVKp33N9A0VoOR2uNc3if9x8r52cwE3JR9whUuJDbHoAGagoQB1
   8qLql8D0pXSTBHZNA8p4RdQDdk7iPW78I7mUz3UGzWOECizb1Xofcw5o6
   fS2ANpMcPmS4412dr79f4bE0QymPd7J5WkUSAOkZFm2AGyaAKPltbG/Q1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="65130961"
X-IronPort-AV: E=Sophos;i="5.93,315,1654527600"; 
   d="scan'208";a="65130961"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 18:06:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvWGNIWRd797t2i52n8JHE2xSqoU9HEPdV5UV7BslcdlIEB1rGSegE/KlwXDklN4QlDopfzhe1E63JEQQIILMQylCR61/bFarDVLF5CRGnTeV0vshilQ448rI7qX/VJvHzqKiNMmWABhPI0R4xkh2QZvRXi64x9LsVbk7qZJlC6269c4VWGqJXzntzOFxABZi+bPdB+KD6Ch8RTdEMVyyymIztpB2RWlvjm2+kYAAVxkPkfmahQtS8Ic5sQZa1vzhmT/tJKLuA8wB9bs75QF726JiATBk3xVnat82ifvxF56gTLkfaYHW8U3p+40A2DYl+B0bHGLcHzbcAAOHn5Y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DNQqdln3Py7csMXE0mynMir2rNmfZO/eILyH+2VOHs=;
 b=G8pbUNuA/+LpqiNwMX/fUJextOWj/spiwph25RMwn/Q8T+RZBMMSpde8CK2WTAdEqUqLrjKt3Vcse7o+ss6bUOG3W3oQO3E7HEKOjdvxMYoBcNx4dPZUH2rMRQSKNX2dci0muNRYXyGV+9leS5RQsQi5eTWFOGCQTIR3v5ae7QB3H7cno/4WREu/ONcJAMl/DDi7PRAKv7QkUwJEEGDC3Rpbwhl3oswlLDcZwfDkCE1bMTgwkXdg5Hs/08+rfvSw66s/WMItoqo+DoChENrALharFBS3jpb+zS3/2jRIBpU6kXrLrh1S3D8bscbpcEC39urWlO6nbXErhRbfwwCrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB5629.jpnprd01.prod.outlook.com (2603:1096:400:44::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 09:06:37 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::7861:36f0:2a19:ad0c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::7861:36f0:2a19:ad0c%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 09:06:37 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "zlang@kernel.org" <zlang@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH] Revert "generic/470: use thin volume for dmlogwrites target
 device"
Thread-Topic: [PATCH] Revert "generic/470: use thin volume for dmlogwrites
 target device"
Thread-Index: AQHYyBlL8iUjjv5ES0aVaBRgA21H4Q==
Date:   Wed, 14 Sep 2022 09:06:37 +0000
Message-ID: <20220914090625.32207-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|TYCPR01MB5629:EE_
x-ms-office365-filtering-correlation-id: e29b7073-3dbe-499d-b87a-08da96306dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGLWW/pNZTJmAIu6jwa3pxXrFt46IgCrYI1Hk22iDtXLO/MADaH2pD5kw1Uj2TUCPQ01loX+gyCiGUhmnPQddthG/UFtaOEjuVyfyCYt2j41T0VV02Dz36Stg3lxe/IpmLcUvu59+/o2ZT6kBc4OE6JkvpUzPAadf+dTNVeULKu89stiD3SfO5lzWjgv0Qnt88MKV6Nk0hFXfpffD8oXVSfiC7hM/ImaeaIMNuusgw3Mu0v23vmqBdx3+z2Na/NJjtPbrBU9HsS7Bo4Zm5B3zHd4iva6XccwP/6EJbOOcCwExlOE2fQN9Of0fSWv8Vw5wskiIsKXA0cI7a+01siSGwdEHKzsp1/W+zv4+8c4tEcVeuTdEbRPntm3kbaUWXitgOpyjDVoLvUMNQ9uTrmlpbPVRr9Duc8XYV+cbtWmD8uKRs0jDUekmjCBMqKPEbYy3yGBX5xPNfGxwdN+HTzSDeidC4RQ0+hcpzQLVhgOkmbzbq7YRVPPnkBXIyG+AaLq4sPOHWEIsLPNwJrlIqfWvK8WVD/opsHO8CBVe2qKYMN/LqkeLHiUWWRWLH0OOvzkHlUF+eLHQD55HNjwTPchjJ3nzc5BB9gtUIdl1dF7M4kWmhcxaycoZe09Cajm9SEMoGerT5MOPtlTQ3lFU2RLp3R6GhFTc7KE0o+dV7EH9KLPOAQseInHZezo0S1KuEkSd/TMy9Rlafyu/zjOgUP+hJimssfy2E/tZmIRrDCKMMWM/m8YAhoiLo6ztnIuz396XlXXS2YWfIGFr+h73YK6R2OLgH+nLf+qDAdR/H9AEAd3/Ec03ZDOtAxrynk5/jr6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(1590799012)(66476007)(8676002)(38070700005)(2906002)(1580799009)(86362001)(41300700001)(316002)(1076003)(107886003)(186003)(8936002)(6486002)(2616005)(6506007)(6512007)(85182001)(82960400001)(26005)(64756008)(5660300002)(66946007)(54906003)(122000001)(83380400001)(478600001)(71200400001)(36756003)(91956017)(4326008)(66556008)(76116006)(66446008)(38100700002)(6916009)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dUVuNTk4ZTdOS2hldjhzTkMxYVVWcGFoMEQ0bUo1OXNxTGJRVkxpKzhrL3VS?=
 =?gb2312?B?L21xa3kzQ3cxd3RmMzFtK1I5NDNKSVI0VjA5ekZickhPbmZhaGNnK3BMV2x2?=
 =?gb2312?B?ZHBmMmdCbHN2YUpMelE5Z25UVElENmh1OE9JckJzYVBqWGFlMmUvaWszeTU0?=
 =?gb2312?B?aDF5ZXRPT1B6MzJnWm10Nkk5bldNaDliSTYrcE5RczJ0TjNRRWJpU2NpdXcr?=
 =?gb2312?B?N2FXMGY5dWZVT25oQ1NFaFFsRDhKUjQzRzBZOC9QSy9Vc1lhSjA0RXYvOXdM?=
 =?gb2312?B?NXpBN2RCeFFROGgvY2RhdTB1dXptc2lZVXlzNHJlZzB3K0d2b0lYNldmTE1T?=
 =?gb2312?B?b2NRZ0dScml3K0IwNWhwTk51T2tQS3JhY3NRY0l3NndJaGJqZ3FKdUJIUTc2?=
 =?gb2312?B?d013S1VUQmZRMzZMbXh5aWFUelBxVFRjcm1aY0lYa3JLNXgzVUxnQnhpSXMx?=
 =?gb2312?B?VTNoS3hINFdxNEhXbWorUklzUCtkeUZ1LzVzWlpkVlE5THZsYzRjOTdQWWFE?=
 =?gb2312?B?YTg0SjFPd1Zma1hQWVltZ2JmZjZTb1FQZnh3V0t0UEFwdEpRTHBURHMyaVFW?=
 =?gb2312?B?MlZlNERETGlvK1lIODU3VXNScE9FMFRQazJ6UUN0QWxkQkRKay9TaEk1LzFB?=
 =?gb2312?B?R1I1dFdxcFJoUDkwVTAzNlVoU0U4L1VrZ1dkTDdIQkpFazcvUXBvOUpZV2ph?=
 =?gb2312?B?T2YyMFV4OUwxMFBaT2RQQVlkbmczZEp0NlZyay92dG5BQVhyZVlmTVMyOXZB?=
 =?gb2312?B?aExXMU8xSkM4NWl4ZERPNFdkRFc1eUJ5RkhsVi8vR3QvaWZ3ZWZQOGRYcFNP?=
 =?gb2312?B?RmJQbm55VnpkalN5cHoyV2d5YzRzWDZQcFBpU21FbzFEVlRRYzBGcmJxSGwx?=
 =?gb2312?B?dWo5UWkyMDdDM0M3M0E2TlBvSWJ0MWxzdEt2K05NNHA1bUpidVZJVWJSYU54?=
 =?gb2312?B?NDBkUDEvZ2Z2RDlJTDNnbXlXNlByR2g1RXB5QkJiTW9QWWdDZlB0TnVod2lw?=
 =?gb2312?B?RDFxNUs5S2huOVdyOTlPSTlOQ3BubFZiR1BaMVV0b0FFUWFPeUU2N2llNmdL?=
 =?gb2312?B?N09OZXlQak1ORXY0RStFMC9Ha1JoQlJ0Z1FLWnAzODVTdGN0ZDBrZm9UdFVS?=
 =?gb2312?B?d1FlcTEzTG5ZTXY2dVRpSzA1dVVKUzlWalY4RnhLaHNrd1gxdFJ5Y2hQMWVr?=
 =?gb2312?B?VzVNb3ZSaGtuVWI1ajBqZnViR1E2dlJoYzVLczU5VHIwRlVJWkZGNlg4YUpS?=
 =?gb2312?B?d3pwZDRNTDlLenYvOXZpWTlhTkh2aXQwT2p5MUM3czdQSVppY3pWSUlWZlBa?=
 =?gb2312?B?VEZRUzBWQ2hVQ3N4aGMxUnVyWlRmL3FCdG1Ib3FSdHBhZ1gzckYvVTdaTHhj?=
 =?gb2312?B?TTRhVk50M0tXVkRPQnFWQlBhQ0lvOS9zazVzWWxvZC93bG1kOS9PNnNacDBQ?=
 =?gb2312?B?S3JjWE80NDd0T2dpenRSWHBIREhJNnFTWFYycHRFb0NQVmUvQXcxQUIxRi8x?=
 =?gb2312?B?ZHVZYzJ5T2lrOGM5d3FtYy9hWVdEbnFIZy9YZGJJRm0rRm4zRlcyWDRQdkVj?=
 =?gb2312?B?V051T2NSQzNvV05aUDVjNG5sQ1ZGZExnZ2dUaitWcVR4QUwvYjJxSFlyMkM3?=
 =?gb2312?B?NDRxckhzS1ROUGVvcG9xekVsNVlKVFJUOU5ZblBKcktRTU1Vay92Zlg4c2hE?=
 =?gb2312?B?Rjk1SEZ0enkwSVVUeXJxNVkyTVJLUGthektqOXJTQWtkb0M1bnNMc3RKNTY2?=
 =?gb2312?B?eG5wVU5Zd0pNTjVGK0lLc1U0Q1dmVi83WkJyaHR4ZmRVL3NMYmdESWNvaE5o?=
 =?gb2312?B?amxHWnFyU3hmR1hLOHA0ZkxONGtzMU9CV2xCci9qSVlucmVBcHhlb1phUXl2?=
 =?gb2312?B?Si8rL2Urc3dHVHYyVVVzd3plR0ZRSEkzRjZjSXV6R1R2anpiSDJabWpyRUd3?=
 =?gb2312?B?VTBrZVV4RkJQZklienZGbDZQWjAxWkV6ZzdSTmtOdDNJeXhLZmlKSG1Gd0Mr?=
 =?gb2312?B?Z3ZCNDdDT29BOFRmcTBqMGJrUGwySmZaalpwWmtpU29LQjBLVCtSMzVBMUpD?=
 =?gb2312?B?ZG1jdFBzdStROTY0V1Y1QXpBQnF1MEs3MEwyczJVYjVvcFJDUEVvdzFReXJB?=
 =?gb2312?B?TGR0bHUrLytCOSt5RUdLOURHelV0OVY0VkF2bU1jaUhodDVNNDNVeDhMTUJZ?=
 =?gb2312?B?bGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29b7073-3dbe-499d-b87a-08da96306dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 09:06:37.1525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2K4Rr5A6Dgg9X7IFPO7bLBB9H9iXlbR0BtT/C7QZUf3NLcFUQ3qKzyzfsGoJnHY4iM2Wlf2l/OwoHMgDZ4dqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5629
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCBmYzU4NzBkYTQ4NWFlYzBmOTE5NmEwZjJiZWQzMmY3M2Y2YjJj
NjY0DQoNCmdlbmVyaWMvNDcwIHdhcyBvcmlnaW5hbCBkZXNpZ25lZCB0byB2ZXJpZnkgbW1hcChN
QVBfU1lOQykgb24gdGhlDQpsb2ctd3JpdGVzIGRldmljZSBlbmFibGluZyBEQVguIEFzIGEgcmVz
dWx0LCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0DQphbGwgdW5kZXJseWluZyBkZXZpY2VzIHVuZGVy
IHRoZSBsb2ctd3JpdGVzIGRldmljZSBzdXBwb3J0IERBWC4NCkhvd2V2ZXIgdGhlIHRoaW4tdm9s
dW1lIGRldmljZSBuZXZlciBzdXBwb3J0cyBEQVggc28gZ2VuZXJpYy80NzANCndpdGggdGhlIGRt
LXRoaW4gZGV2aWNlIGFsd2F5cyBnZXRzICJbbm90IHJ1bl0gQ2Fubm90IHVzZSB0aGluLXBvb2wN
CmRldmljZXMgb24gREFYIGNhcGFibGUgYmxvY2sgZGV2aWNlcyIuDQoNCkJlc2lkZXMsIG1tYXAo
TUFQX1NZTkMpIHdpbGwgdGhyb3cgIm1tYXA6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkIg0KZXZl
biBpZiB3ZSBtYWtlIGdlbmVyaWMvNDcwIGNvbnRpbnVlIHVuY29uZGl0aW9uYWxseS4NCg0KUGxl
YXNlIHNlZSB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIG9sZCBhbmQgbmV3IGxvZ2ljOg0KDQogICAg
ICAgICAgb2xkIGxvZ2ljICAgICAgICAgICAgICAgICAgICAgICBuZXcgbG9naWMNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGxv
Zy13cml0ZXMgZGV2aWNlKERBWCkgICAgICAgICAgICAgIGxvZy13cml0ZXMgZGV2aWNlKERBWCkN
CiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KUE1FTTAo
REFYKSArIFBNRU0xKERBWCkgICB0aGluLXZvbHVtZShub24tREFYKSArIFBNRU0xKERBWCkNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFBNRU0wKERBWCkNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpJIHRoaW5rIGl0IGlzIHdyb25nIGZvciBnZW5l
cmljLzQ3MCB0byB1c2UgdGhpbiB2b2x1bWUuDQoNClNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8
eWFuZ3guanlAZnVqaXRzdS5jb20+DQotLS0NCiB0ZXN0cy9nZW5lcmljLzQ3MCB8IDIzICsrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTcg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0cy9nZW5lcmljLzQ3MCBiL3Rlc3RzL2dl
bmVyaWMvNDcwDQppbmRleCBmMzQwNzUxMS4uOTNhNmUzZjQgMTAwNzU1DQotLS0gYS90ZXN0cy9n
ZW5lcmljLzQ3MA0KKysrIGIvdGVzdHMvZ2VuZXJpYy80NzANCkBAIC0xNSwzMyArMTUsMjIgQEAg
X2NsZWFudXAoKQ0KIHsNCiAJY2QgLw0KIAlfbG9nX3dyaXRlc19jbGVhbnVwDQotCV9kbXRoaW5f
Y2xlYW51cA0KIAlybSAtZiAkdG1wLioNCiB9DQogDQogIyBJbXBvcnQgY29tbW9uIGZ1bmN0aW9u
cy4NCiAuIC4vY29tbW9uL2ZpbHRlcg0KLS4gLi9jb21tb24vZG10aGluDQogLiAuL2NvbW1vbi9k
bWxvZ3dyaXRlcw0KIA0KICMgcmVhbCBRQSB0ZXN0IHN0YXJ0cyBoZXJlDQogX3N1cHBvcnRlZF9m
cyBnZW5lcmljDQotX3JlcXVpcmVfc2NyYXRjaF9ub2NoZWNrDQorX3JlcXVpcmVfc2NyYXRjaA0K
IF9yZXF1aXJlX25vX2xvZ2Rldg0KIF9yZXF1aXJlX2xvZ193cml0ZXNfZGF4X21vdW50b3B0ICJk
YXgiDQotX3JlcXVpcmVfZG1fdGFyZ2V0IHRoaW4tcG9vbA0KIF9yZXF1aXJlX3hmc19pb19jb21t
YW5kICJtbWFwIiAiLVMiDQogX3JlcXVpcmVfeGZzX2lvX2NvbW1hbmQgImxvZ193cml0ZXMiDQog
DQotZGV2c2l6ZT0kKCgxMDI0KjEwMjQqMjAwIC8gNTEyKSkgICAgICAgICMgMjAwbSBwaHlzL3Zp
cnQgc2l6ZQ0KLWNzaXplPSQoKDEwMjQqNjQgLyA1MTIpKSAgICAgICAgICAgICAgICAjIDY0ayBj
bHVzdGVyIHNpemUNCi1sb3dzcGFjZT0kKCgxMDI0KjEwMjQgLyA1MTIpKSAgICAgICAgICAgIyAx
bSBsb3cgc3BhY2UgdGhyZXNob2xkDQotDQotIyBVc2UgYSB0aGluIGRldmljZSB0byBwcm92aWRl
IGRldGVybWluaXN0aWMgZGlzY2FyZCBiZWhhdmlvci4gRGlzY2FyZHMgYXJlIHVzZWQNCi0jIGJ5
IHRoZSBsb2cgcmVwbGF5IHRvb2wgZm9yIGZhc3QgemVyb2luZyB0byBwcmV2ZW50IG91dC1vZi1v
cmRlciByZXBsYXkgaXNzdWVzLg0KLV9kbXRoaW5faW5pdCAkZGV2c2l6ZSAkZGV2c2l6ZSAkY3Np
emUgJGxvd3NwYWNlDQotDQotX2xvZ193cml0ZXNfaW5pdCAkRE1USElOX1ZPTF9ERVYNCitfbG9n
X3dyaXRlc19pbml0ICRTQ1JBVENIX0RFVg0KIF9sb2dfd3JpdGVzX21rZnMgPj4gJHNlcXJlcy5m
dWxsIDI+JjENCiBfbG9nX3dyaXRlc19tb3VudCAtbyBkYXgNCiANCkBAIC01NCwxNCArNDMsMTQg
QEAgJFhGU19JT19QUk9HIC10IC1jICJ0cnVuY2F0ZSAkTEVOIiAtYyAibW1hcCAtUyAwICRMRU4i
IC1jICJtd3JpdGUgMCAkTEVOIiBcDQogIyBVbm1vdW50IHRoZSBzY3JhdGNoIGRpciBhbmQgdGVh
ciBkb3duIHRoZSBsb2cgd3JpdGVzIHRhcmdldA0KIF9sb2dfd3JpdGVzX3VubW91bnQNCiBfbG9n
X3dyaXRlc19yZW1vdmUNCi1fZG10aGluX2NoZWNrX2ZzDQorX2NoZWNrX3NjcmF0Y2hfZnMNCiAN
CiAjIGRlc3Ryb3kgcHJldmlvdXMgZmlsZXN5c3RlbSBzbyB3ZSBjYW4gYmUgc3VyZSBvdXIgcmVi
dWlsZCB3b3Jrcw0KLV9ta2ZzX2RldiAkRE1USElOX1ZPTF9ERVYgPj4gJHNlcXJlcy5mdWxsIDI+
JjENCitfc2NyYXRjaF9ta2ZzID4+ICRzZXFyZXMuZnVsbCAyPiYxDQogDQogIyBjaGVjayBwcmUt
dW5tYXAgc3RhdGUNCi1fbG9nX3dyaXRlc19yZXBsYXlfbG9nIHByZXVubWFwICRETVRISU5fVk9M
X0RFVg0KLV9kbXRoaW5fbW91bnQNCitfbG9nX3dyaXRlc19yZXBsYXlfbG9nIHByZXVubWFwICRT
Q1JBVENIX0RFVg0KK19zY3JhdGNoX21vdW50DQogDQogIyBXZSBzaG91bGQgc2VlICRTQ1JBVENI
X01OVC90ZXN0IGFzIGhhdmluZyAxIE1pQiBpbiBibG9jayBhbGxvY2F0aW9ucw0KIGR1IC1zaCAk
U0NSQVRDSF9NTlQvdGVzdCB8IF9maWx0ZXJfc2NyYXRjaCB8IF9maWx0ZXJfc3BhY2VzDQotLSAN
CjIuMzQuMQ0K
