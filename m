Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DEE6D9D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbjDFQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjDFQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:18:25 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE1544B9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1680797903; i=@lenovo.com;
        bh=h/7A+n0vzMcjFxVCE6iQeVqUYEjVHxrloqqy17rFXBk=;
        h=From:To:CC:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=3oPQ91qSMz9OdInmBagtimzBY1bBcXt9WA26sJ1Dqj1ChlklukC9WBX5snaIibEZp
         384cCmaRMKZB9CIT6gwKx1Di/58ITkkuAc0wXE8CvMDtMD0DZcU69UWIF0WEJR/Z5Q
         CbArNqpws26H3c4wIr2C5i59EDUxuB452yZsh/z3kyQ5afFeTLkgZx7zACFTLvvlQR
         tvRdoQJvLtQstWTpOQ9SRID6PRsXOS6rjLGiY44O5JOAUbwPlRaHiOP9i1SBJmFf5M
         Q1ELVV0mHf7c8cYcw2Ws72Wq+kxtk1oacF+lj+29Y+9+Y3mT9dnNIYUk8a4sizHxjB
         j6RctRC9IY2Ww==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRWlGSWpSXmKPExsWSoS9VqHvug16
  KwYxXrBb/9xxjs/jQuYbRYuXqo0wWkw5dY7S4vGsOm8X8ZU/ZLda9fs/iwO4xsfkdu8eCnvPM
  HufvbWTx2LSqk81j85J6j903G9g8Pm+SC2CPYs3MS8qvSGDN+LHqJ3vBHe6K6/dPMjcwzuPqY
  uTiYBRYyizx7tN/NghnEavElv0rmSCcDYwS3b8+M4I4QgLzmCT234YoExK4xyix6NE8IIeTg0
  1AXWLRrNNgLSICHYwSPY8mMIM4zAJbGSVOXpjIDFIlLJAssfTeK3YQW0QgQ+LUsgtQtp5E784
  1YJNYBFQk+psPsoDYvAKxEmf/P2YFsRkFZCWmPbrPBGIzC4hLzJ02CywuISAgsWTPeWYIW1Ti
  5eN/UPUlErdermeDiMtKXJrfzQhh20usO7KLCcL2lXj0dCM7hC0nsar3IQuELS8xbdF7qLiMx
  IMb28FelhBYwirx/dw0RgjnGIvEtWuboa4wkJj37QhU1Tygk/qnMEOcqiOxYPcnNghbW2LZwt
  fMEK8JSpyc+QRqnbTEhPmrWCYwas5C8t0sJO2zkLTPQtK+gJFlFaNpcWpRWWqRrqVeUlFmekZ
  JbmJmjl5ilW6iXmmxbnlqcYmukV5iebFeanGxXnFlbnJOil5easkmRmBaSylKWreD8UzfX71D
  jJIcTEqivHNVdFKE+JLyUyozEosz4otKc1KLDzHKcHAoSfByvNdLERIsSk1PrUjLzAGmWJi0B
  AePkgjvzXdAad7igsTc4sx0iNQpRl2OK9v27mUWYsnLz0uVEued+xqoSACkKKM0D24ELN1fYp
  SVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMK/wWaApPZl4J3KZXQEcwAR1h668DckRJIkJKqoF
  pYWDmzhir+e4qsX1FH4J6+SZZ2h36sl2WmTs5Zy3riueTkr6KT128N4WXzWtXc6Gt9fumjlkK
  NxplNN/Xuyx9wakgK7Htp/7/u6aLjrBdDHvfo1U901jcTfm0SJLP//8NU98fXHz6hE7qZzEfi
  5evCo/HJasxSsnPf3Es+nfQTqXcm8FCHzM+7lh+6adk8IwG0bnMdQdOp+gFebx83P64QvPLD/
  3klNXH5yhyP6mbP11pm5OTsssV822Tm9sTOG9OzloY0dS99KwCwzn7WzN5bu7ZePLpKk+FSxv
  vF67ydGsq5gzj+Xp1w7NDfksfhzdvvfbqRyb/tqPyao0LDh3/depNlXx6TffE4F1Cm5ZcV2Ip
  zkg01GIuKk4EANMmO6NyBAAA
X-Env-Sender: yinlei2@lenovo.com
X-Msg-Ref: server-6.tower-655.messagelabs.com!1680797900!24315!1
X-Originating-IP: [104.47.26.113]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10498 invoked from network); 6 Apr 2023 16:18:21 -0000
Received: from mail-sgaapc01lp2113.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) (104.47.26.113)
  by server-6.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 6 Apr 2023 16:18:21 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu/GuPs6mucHzJY2BfQr9AmjaD3tFdPj+3FFl8ylqx352HFNGrQAABPsFLNu+8XA0YJQ9T4+IpZSPAomip6stffhEwgWUdW2BaEEs5Sx1tBo/8w/u2nmE6ubbfaoOZUnngPYOj1hRhfLefoLScb21/bvc5v5CaTd7x6TOdTjfMuBGYR1YygY4duObfgfsBqLnCeXb1+avimxgtMtvlhqqjmkXi50zmhV6vrQ57a2Eqny410/waWVW/MODPUKyD00rOPVa9+SAJK0MvZYVNJw9dgeszIBp17YpUdJU+ub8h+zq2Q+NF7ffoe2UmtRpb8lu3nF70Sw4+qM32a+ZaOFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/7A+n0vzMcjFxVCE6iQeVqUYEjVHxrloqqy17rFXBk=;
 b=Lfnkw88z6u70PC5qqnet2MByUoIUzjOp0QTqP5SgkCZxck8/uKRN5IrGUGldA6yXSqWngS2hrtSS2+s/fBI34uzJPaJ/PXailj9O9VbkGi+5MDPpbI1M1j8+2cKj++LZIYVPMMK7zSWov1vuBX5KhvHu+e2RHZIL23ELPegGaHxVer9fZUFT69WCY3I+3JCP3Oo2oegIN94sGQHeJPsZmMyrxMlM+JHd8fwJaF+UO4Rvjwc/3vqxN3JOeTQhUekWBoPoK/vi/aG6LrEQea3sO5v74mBvdNcmgAGMoJCZ2fIfm2uH/hvS8SVI6Nr3UV8gk0HfCmp7nSOgVvy3muxvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com (2603:1096:300:84::21)
 by PSAPR03MB5464.apcprd03.prod.outlook.com (2603:1096:301:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 16:18:19 +0000
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::d2df:bfd7:dd18:5e56]) by PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::d2df:bfd7:dd18:5e56%3]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 16:18:19 +0000
From:   Lei Lei2 Yin <yinlei2@lenovo.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: [PATCH] nvme: fix double blk_mq_complete_request for timeout request
 with low probability
Thread-Topic: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Thread-Index: AdlookLWDq+ZQ4LKSB+WnMnjqCG8eg==
Date:   Thu, 6 Apr 2023 16:18:18 +0000
Message-ID: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4939:EE_|PSAPR03MB5464:EE_
x-ms-office365-filtering-correlation-id: cbf169fe-d686-4b31-7e38-08db36ba886b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJyg2DYQobTzDoJjgi0aB9Sb95z+Vp3OScDB7nRCAYzpPuC8oRDUQCGZ+hfu0S8u9vlUNp041FSLB9cpWVySYb/Dkj4WP3jBNPm7mq0eH4sgLpgFxiPGmxOPRZl1zsYGl4OAVOluIrNCwBjD+HYyBKDOMZTUkpkN8obZdy5qw4oYto8jCVdSe6GYxP4iIGo00BQ8rw46/rTJoskzNRsBlxfKydRpA37IkmmGOT7973+moC9DdWEHlcoZqS9QUIGC/b3A0donhvIPEHC/+xKZ9svN6/xXs8kOt1rKmpfQxTmn+KkwKukMP68LU3gKc6qFBJ2EZjNgH7Eju7tvIgRJviyVz9EdZt0Vby5Znu7+qI41HyIg3+1ayMwoYttLkjegdMOMHYWly5pRTTsVO/hfkW/CECGHqTkCAAjBrAR5gDBRtSgee7McvD3evRJi9YvDBhi7XMikXbLsvdQQxg5DXpomDANzFEbHvNxUguJx7Dd95KNL4F779ywA1Xnu1rNFVT17X112bqy71EucV7aVzzm3MUCGekfoAsCRR240d5Y0jPvzTEGy5joeE9ql89ijMC7OPYS+ZvSnAIZE+Qnxm5cpztJx9jtXSRUqwwJ13yPKsNolWD0lak/DVorSYldz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(4326008)(38070700005)(71200400001)(478600001)(66946007)(66556008)(66476007)(54906003)(7696005)(64756008)(8676002)(316002)(41300700001)(76116006)(110136005)(66446008)(33656002)(86362001)(53546011)(26005)(83380400001)(6506007)(9686003)(55016003)(52536014)(5660300002)(82960400001)(186003)(2906002)(122000001)(8936002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RBQ8sFZEEMd44WeGSBmPAqsXKSaCQxAAyaMugMuUuLtMeElWi3I6c+cb1tEA?=
 =?us-ascii?Q?NuNU9Aj+3kUXPeMawMPWRhpJ3aGWthsZNrL6kGYEgvarPfJyKrEOZqszzUW3?=
 =?us-ascii?Q?ajYfpM5n4ZDcU7fpjHz/nKYwrVvF/iMjQnzIEaIlqNlZIKYLVvBnxhArANWM?=
 =?us-ascii?Q?Y1dt5u/bYr/HXFUPwLdpdQutdlKTVOlG1E/JZq0Ua5JgucMpSek2ZkYMT8KX?=
 =?us-ascii?Q?8PFuxugS9VfyIxX6mCbqiczeGdC69beM3KyGwGfUo+tq26q4J4xjz5kOdvj5?=
 =?us-ascii?Q?o6eLKXEHlIwLo3jDKLuu2n3K7ACESmzbuBB6LN806I7KX55DkMHkBsw8SFRI?=
 =?us-ascii?Q?Gr7ez/4082Y6eXMntURBMcJyFlRMp5pumCkjUeomoCjucX7tHlsMy00TLIsU?=
 =?us-ascii?Q?+VkB346opsYadJMeOg11kdoAMp6ou7//RxVG886jXbgmDlvVqx6At3hz4wqJ?=
 =?us-ascii?Q?YiKIdf1VysVaYTh2oVj6JP4R4IiOMcqgMmtTYF3fojN6jLFenN1T2aBwTDY0?=
 =?us-ascii?Q?Q3EICNJayt/pHV7a7uoMDhx2NA+Pt+4Oj92nHrzV8chI/WfCnVp4iyUUGE8x?=
 =?us-ascii?Q?nvIowGSHwwpp5DtSv0xy/wzTA+NZp85RlwW4I+2+oQXe8T0orptfj1iDIO4G?=
 =?us-ascii?Q?g0ySE6lb9oPQA8Oz/UpcjSD2zrNGO+n3SCiAOgnmzDnWZIjVNDc2BlAsxfo4?=
 =?us-ascii?Q?+QKIx858FtGdkbOzbsxe2bXBupx89y4KtgGLiec2zcswl/o1EbwipVaNDFCP?=
 =?us-ascii?Q?KJWJcyg/bTHymifdbLudApBIzw/qs+3Yeve1WT7bSHq9q6xDePv70HZCHuHs?=
 =?us-ascii?Q?FGr8CkIyDxwJKwYvWia9MnambTTOcVS81ebJIoPj88caSZtSb+NhNQe0X6T7?=
 =?us-ascii?Q?Lo/XuYbiM7uaVqFj4pp/rWrJYPiBF2yEZ3CK07gvBRKYoZXZFLA/J4CR9vGu?=
 =?us-ascii?Q?N76PTnSODf1WyRelcMhk9y10zR1lnqGnA9mh4WDjMi2IzBbHXvlxZ5yHOIPz?=
 =?us-ascii?Q?jDt6iQjfGrEtHDfj0JzLblrM2W4mg4qbLyP7XDvEMSfziooawQmHktaAE6ZU?=
 =?us-ascii?Q?Yh24coCcST+WmqO/IuNRWKg6MdSKsGm3cRPzbjvlv1uuW8aVrRpQD9bDo6pU?=
 =?us-ascii?Q?J+CzGPtSXubq2toB0NYlae3hDHUw0ilNpHcg1+U8YJ6ky2Oc/eZY34UH/VUd?=
 =?us-ascii?Q?gFIdr0r3kMHT2I8/fj2nLCPWBlW0oUNjlN4WIaasnOdYUX6Uc1rbX1QcbMip?=
 =?us-ascii?Q?ZHIpDp7tN3fNS0UTDwsBzJl78UustmBALIIZDmJhy+Hrn1FfOq4T27XuvOnG?=
 =?us-ascii?Q?WikrI91K2AMg1+9csVfS23a9IPoZcPTFQvsRb89+le10WeoDv5iSCCaF/gBP?=
 =?us-ascii?Q?I2It2k1Zb0itRwLUHRIvrZidP1gWGhIQCtl+MZZqdmSYYvBK/rDp8s/Lu8Zz?=
 =?us-ascii?Q?iP+OQUslth6QdwbQCS4b1raBz7R4s1afH4zamlC2dDepnfmNt5eN2flg4z9I?=
 =?us-ascii?Q?chw6IY4f5gfkanCjH4gR04BCxknABHqC42ZyOohbauU2wiL3pH4JR0bTwTVV?=
 =?us-ascii?Q?qrvpNwNh8M9ewiuYmOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf169fe-d686-4b31-7e38-08db36ba886b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 16:18:18.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt9oB/GTpoe+xof8I+n2PlWaS5t95R8so650/j/Wlt7SBs0yxRgmDOXeqi/+b3EnuJqd8v4dKp02ibDIOIABHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5464
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 612bdaa44a8bed09cf8da15df0ad98c018fb5ae4 Mon Sep 17 00:00:00 2001
From: Lei Yin <yinlei2@lenovo.com>
Date: Thu, 6 Apr 2023 23:39:11 +0800
Subject: [PATCH] nvme: fix double blk_mq_complete_request for timeout reque=
st
 with low probability

When nvme_cancel_tagset traverses all tagsets and executes
nvme_cancel_request, this request may be executing blk_mq_free_request
that is called by nvme_rdma_complete_timed_out/nvme_tcp_complete_timed_out.
When blk_mq_free_request executes to WRITE_ONCE(rq->state, MQ_RQ_IDLE) and
__blk_mq_free_request(rq), it will cause double blk_mq_complete_request for
this request, and it will cause a null pointer error in the second
execution of this function because rq->mq_hctx has set to NULL in first
execution.

Signed-off-by: Lei Yin <yinlei2@lenovo.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 53ef028596c6..c1cc384f4f3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *dat=
a)
 	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
=20
-	/* don't abort one completed request */
-	if (blk_mq_request_completed(req))
+	/* don't abort one completed or idle request */
+	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT)
 		return true;
=20
 	nvme_req(req)->status =3D NVME_SC_HOST_ABORTED_CMD;
--=20
2.39.1

