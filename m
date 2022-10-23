Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5402609210
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJWJqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJWJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:46:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D5951A21;
        Sun, 23 Oct 2022 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666518361; x=1698054361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qovBzeuiFEIPRhaVG5Yv8OY1xUmzoZI0VuH3qCe4BWY=;
  b=K0alkZ7FKMKxuahSa2uTOg0pJyvEazKQjN4yFgtYrHaijLstNcG+CIgh
   0WCniCFoA4Y3BrJbhMdGw4w60GYkO2+63BHbPp7gHTrv3blRinqTRuzIX
   Es/CKCLDMxPKnVKutlLGJ6zAmKCmYeOcEkRhKNWP1b4Sp41CSh82J4VVs
   7xg0cbizwkJQLda/lN5gQOZDlKXIMGzWHZxrahOpVHIYyzV6cqGKFL720
   04xiahiupWGPMC0ycpKwSGrOHipQVc5UcFHqCe85rNAGETU5TrJkw9/01
   XQjc5+q5+LAskp2gTz9Hfyo8qchJAaz+8g0goloOy4jEHB+G+6l0KkwXe
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,206,1661788800"; 
   d="scan'208";a="214903252"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2022 17:45:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGjT0yWiYg+msgCG+JJxlbiEGaRKCFxFEbyRozoW84GtUqizD7Tu43lx+rEHemzZK064IKF0ADPOys0kwTmFEhnw0Hl1DWRR3rUpzX7Pdnu3HqfDK7NKxt1Saye7EeU3HRLUVNq/KTnyU37G6bDZT6PXpcesC4vUF7I53+rDFIH3ORy5TUFPH8IbZTTVvqfrlXjehrl8/DrRHbEx76UzbmzV/E1yYpeBAnYumrPj/KKJ5WRR2gCme/TmCmwu+med1gpFhK/JURpuflRIHlTftrPHZ2egeP/O2jceCp9TMoUD023X5v79B+5EYeskmTZtg+8evkzVtJHGiNpgo2w+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qovBzeuiFEIPRhaVG5Yv8OY1xUmzoZI0VuH3qCe4BWY=;
 b=T9ZM6rM0TzupKbMTb/DstYLH0uoUElGqE9DfXMw3/jaWAOZEx/VIalavNjdKlCF4wYLj/N7F+mNqdTl1+TbKHyIlj8GTW+4L1aNtgq1GHFrx8ya0M3D1quW+zSsQS4uKxb5+T7843o+5PmoxtMbYjujTzGKiHoiwqx6TlBRZfi81ed0HUsLjIot9jhcnsstllmmPmgbjxmn8ocr6oyvfhkXUUyN5p0E73hzgy4pnEve2rQNAyNCSIZwEojt98yxWTKKlRzW14yZx/muVb9FYlA+aUmI6wkkEhrRJeoYY35+D+l/4diWeK3Mzv80ruAx1o3CwPZKpJQozw8NZ+15DdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qovBzeuiFEIPRhaVG5Yv8OY1xUmzoZI0VuH3qCe4BWY=;
 b=pCVrdtoyQxJveOhaqSjbxWoo+E35FXnqx9HnjDAAvg5LeX7Jqh/KXhnl1CvWyBViHTYl+oBgaYLUC/P0p5eZERhthe9j6LPae4ZwLr5LF4tyGPCy6z6C2+lkIwMsjeGPY3EwhKADtgaUGKPz1dnRwAYladGLE6XfM2vfENrXjuk=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by SN4PR0401MB3584.namprd04.prod.outlook.com (2603:10b6:803:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 09:45:56 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::49aa:c6bb:bd87:e26%5]) with mapi id 15.20.5746.023; Sun, 23 Oct 2022
 09:45:55 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: RE: [PATCH v4 1/3] scsi: ufs: core: Revert "WB is only available on
 LUN #0 to #7"
Thread-Topic: [PATCH v4 1/3] scsi: ufs: core: Revert "WB is only available on
 LUN #0 to #7"
Thread-Index: AQHY5l55sMKPiuucHEmLpEc2Nh5CqK4bu4rA
Date:   Sun, 23 Oct 2022 09:45:55 +0000
Message-ID: <BY5PR04MB632719618EC1A445F89D5A27ED2F9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
 <20221022213650.626766-2-beanhuo@iokpp.de>
In-Reply-To: <20221022213650.626766-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|SN4PR0401MB3584:EE_
x-ms-office365-filtering-correlation-id: 5bfc0dde-4606-47ba-4178-08dab4db6175
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTV02rbZvWn7pWTgR8XoPYZTjKC5+m+JvN3Nffb/bMVOs5HKIXiWeXl++Sk51ju7obzw9T1GUwemBlxUZFWOEdMF7lQdIzqv4DB6828lEU+8r3CvBED/1ib9SNqDsmv/W4UjqWAjn9L608DANYi6X/1XLVs9AmC/cBu04JgjOjuLEdUE59vt9Xb3a0Fbkl8C5RDyvPxazsJuv4XEov+u8v1Fz3nwV3Q8SsBLZGKtYQ6kzws4fwO551PUXWLOwC4sQiZR21NZNqH/181EV7wlFNcZb1BaFE4Yo6qds/+V1pXu+vjrFgUg81xX7cu21IueBy2atQdRGqkmjxhlQemToNe7yvJwuuXxy903BGCyfkbZ+2Ni+LClnPH9rdDuAXjRcYqvca3CEX+veYpqm5NUAH/lZpuM23CPCar25mtHnwGrSgCbBuf0HBjds/+zaKkxksiYrwsR6HPArh0NCSqb1Xz8KdAYzXGA2UvsDISDzkZJmNy2ek64+ueDCIK4c8Cc9qC6+akkt4C0PkF9h+j5527AIFOq/2sPPTfTqGJEEO6C0yp4YLkE49tH+hygY6IQLa5xqTL9+q/h5MD9Otv1nJOyZVarezLwj7RuXfFsECVkA7jzaZ9euYiFjuPGJjOrw2cx4oL+9i+j+a2rctjox0xRG5/l7DjITPX6hv0JmOY7GOevRsTR8p4OHcEkKD5JsZNcnUXLfoN6HfrTAkFNiCaXq2QFObzBzB6mG+xb70rTizF66MYyxXpwa9HQhnK6vEHPRGUlCPAkvha/WOjbNk0gWDJo7Soa40lZNarc0jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(66946007)(53546011)(76116006)(8676002)(66446008)(64756008)(66476007)(66556008)(6506007)(4326008)(921005)(186003)(55016003)(7696005)(83380400001)(2906002)(110136005)(9686003)(41300700001)(26005)(5660300002)(7416002)(52536014)(8936002)(478600001)(122000001)(38070700005)(86362001)(38100700002)(71200400001)(316002)(54906003)(33656002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZBsQDgV7DN+PJ3qcC2F5Y2hEzqBw4DJxNdBfm3+zBzNp95yPkR9c/QyDmQst?=
 =?us-ascii?Q?eMyHXmxCAQvIbCyClWm6L1CUIIQCtQnI1690J8IL3Y3LHwUpy82iVEZTrI2x?=
 =?us-ascii?Q?gzTMSFHC7+I/jkN6axQSd6EyOhtSzPsBCRD3IctGBSfAuMW8dn4/E96Oveyv?=
 =?us-ascii?Q?9NZsF1DOjUp33NvOcoxP1NPD+awE29ZQwcnnHSvoHAhQWLoj/1Pe+c/Ceq5l?=
 =?us-ascii?Q?tU+jxd4k2jxcZneIKJMcERgYtIMt5tP7e3cRE9dgkQCUN+GL8Iw3d0U4nJ1K?=
 =?us-ascii?Q?4/Iowe4gqcrZtI8qcK8u2HFe+A3IHqWHzwL+Udo0CMDTpdrqbjCUqjzB43CR?=
 =?us-ascii?Q?UuPRBku7RfUYldrJKCpPVlDaUxQSmC6D036YHgsyjAu0sPdPVXuw0Qvc1+an?=
 =?us-ascii?Q?XWNLP8p7vkbkmf75Xw/+/GViLLVuK2b/Ev1mC1eDBpQ+ahYNqTSGgDD/sSLc?=
 =?us-ascii?Q?3UbByWIwGTnHrrqmgllNilpg8taait80DpNDEayCM1DTAHbgNt8iB/WKUc7f?=
 =?us-ascii?Q?dMZc9qU0sFMRYTqIv983ZPBBZlRNBbM7asrMe+WWMZFahoPsBcQWWNFs2uGZ?=
 =?us-ascii?Q?ilfjTW9UkSccAhQUA9JO78aCfRfAn4kULVOwBjXH5qpNTP4I66K6Fh1zfmI+?=
 =?us-ascii?Q?AuOxGHoUDf1JowiBripm+v5eeuvKr6fVMrRPgm6nz2POZSiOENiRBXk5Jc8W?=
 =?us-ascii?Q?47ng++ChUOlFFsyCydyy0FTY5+ioSxeGk2nJw8Vc8UeaDZvSaiAFu6cYb6pl?=
 =?us-ascii?Q?bbjTz2hrqsafWWldRGccN86Cwsz7JpR6354JHyYUkxpRZ4nYMoWnaGMkao33?=
 =?us-ascii?Q?xUWVuNp2O54bBYqymnMDtxDzM/4SgNKs7wIepVKTJqHWrlrX3GN918kJRw0S?=
 =?us-ascii?Q?Kw/MvcLZ6tSnCaQVmWAt6NiNm4YnCQqgfcMNJPLr6RAP5QxXFbDGpMCrnygl?=
 =?us-ascii?Q?DJQbuwSWzSc3ayhFJVfX5iozGRsiSucU5uJyfuTaH8RUr7ZayYYiNSsLn3bF?=
 =?us-ascii?Q?1/Nv+k1za+1jbjyN/UGb5NNoYFnbXWoIe2ieuoxwf/3Wj5WyS0aU0gVEurtt?=
 =?us-ascii?Q?hFlMPpm0Fl7B0rjQMorL4Ot5KorVUvGJgSOcYy71SnBo8aIDMwu4Vg2fR83K?=
 =?us-ascii?Q?BEcGbi9uY2jK2bKmNRK+pvJY/BEW9740wvfc3/5idVEdv7DRw4+7ityVI0BM?=
 =?us-ascii?Q?VZA6X8d4ZFodiQdUJOm+w5C7vBksy4nzlGzR23iJ0NWKk/74lka7m9JcPmL0?=
 =?us-ascii?Q?Dytkg7IUiQCxAAU4ojYUoJOHtJ8a8bxPDOUyaGljfgvoYpzpadvbPCp2pcpM?=
 =?us-ascii?Q?qfnyMRBUmnvG6xHOHEmGzXfbH/ZcpeaD7xGaKsqsaJbwB8c3C+MHOj51xGRe?=
 =?us-ascii?Q?aTia9+AVoeFifRRdEhHUus0btW2bwhaRSdxw+26z/JDhQDxeiTnKq1i5iL3w?=
 =?us-ascii?Q?ooy+ME20thd6gzwlSMapb8EEnDsfHJQdG0xCy/zHb6L5BD3RTFZB9cwA+J6/?=
 =?us-ascii?Q?V3arGt1UUY/NWMrnVVESHiNCTOUMkBfkaJxtIGFzNHBFhNDoV8z3cWvmzVcW?=
 =?us-ascii?Q?bQeobBcMrTm4e9gmq1JMvU0U6HJtLBYssAEsxcq2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc0dde-4606-47ba-4178-08dab4db6175
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 09:45:55.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Lq6f2BnmhjCEXxAH9FmwSZLaOq4bwd1Eh7n/dFn8zH3t3NsdItP6LQwjXzCy8BXxc4kYQI5Sss0QiwdS0uNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bean Huo <beanhuo@iokpp.de>
> Sent: Sunday, October 23, 2022 12:37 AM
> To: alim.akhtar@samsung.com; Avri Altman <Avri.Altman@wdc.com>;
> asutoshd@codeaurora.org; jejb@linux.ibm.com;
> martin.petersen@oracle.com; stanley.chu@mediatek.com;
> beanhuo@micron.com; bvanassche@acm.org; tomas.winkler@intel.com;
> cang@codeaurora.org; daejun7.park@samsung.com
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Jaegeuk Kim
> <jaegeuk@kernel.org>
> Subject: [PATCH v4 1/3] scsi: ufs: core: Revert "WB is only available on =
LUN #0
> to #7"
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick
> on links or open attachments unless you recognize the sender and know tha=
t
> the content is safe.
>=20
>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> One newer 'commit d3d9c4570285 ("scsi: ufs: Fix memory corruption by
> ufshcd_read_desc_param()")' has properly fixed stack overflow issue,
> 'commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to #7")'
> is no longer required, we can revert it now.
>=20
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Reviewed-by: Arthur Simchaev <arthur.simchaev@wdc.com>

