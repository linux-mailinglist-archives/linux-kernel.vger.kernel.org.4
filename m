Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09545ED667
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiI1HkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiI1Hjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:39:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE1B10CA79;
        Wed, 28 Sep 2022 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350667; x=1695886667;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aV+WGmwJTZKQ9LQgQ3ekpxRyBsfiBE5PFK+6j8flnR0uMTvsuNaNJsmX
   PwzlqxQ3zenePJx8jHWea7fBHr3YBdBMfeiFzUAD55gVpfJETAjD7J1oA
   5/TrDvemFFkgYRZD44M7caOiIm47ujCRC+wuzgGDPDn4LH7BBEXEIussj
   kSKYZJYdd0XF/LisQRrGNUQWEployh4N8ul/DV1sKNciznTbGraW1j5Eq
   NMRwbZzbR1xKjvBUhR/SuizWXYxQcGIzC8tNmnL9unMK64iZ3GTEasWb8
   ASHx21rAWHLKq24W+W5EgYnij8nNFmlFVXT6MeHsHhsCjtqiaz/BnL5tX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="316748807"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:37:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4uBkCsBp5joY8490h2h7BreASsVUwc55m0PEOpQ3wN688zRyp9HEq37lT/PZHxunHKgzHU17CzE9aIN9HNIfqwiOSTY+a3HZsfjqt+wSZdhi1eHQh8hJGxevoFCfJenxAw/03T/IJLZ0TVzsCK/fd5GyG3VxkdXQZJywDQ3iTmdbls3cLwYTv5S8SPLZY2fJ1/fdT4bdAkWE5GApSXhAr/c0qOBNZkaxEPf01YyPAgqyILafr8fz/rX5AxSUyDYfuin2Tva/ajjOWzNHnWUu5vUYMaJ4/iVfjN++JT10OqLnc+nswSww44qBOM9xtRv55fN0/Ahqf0VaMPb1vPJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BrGSMzq0RWyGimlgpMzfsLc2Mo1hX+Jht+sebD2uIPkwNtvV4SxsuecQMNJw7HSZ5gaG3Ifxaay+Ge8f3NAU3Znq/NCuhF1aWvLfsQwftTn3TGYAQRwwBCzsY87x5tZfczcTFMzjn+bcT44UbYmEiwQ7DJvSyJKlnjORPrx5+rCt107I08YFDVrNuXg8lBMZklYxoLsPzsBFffMClBUPL9W174QnW6ki5pwfHqooCwCqdLo7gF6IrXp8jJj3PSrfKza3IaLOwNxsEkvrJsS4z4ES1T+QqatfpSdxTE/Djlg9lXVImXql+IioCdNDLIQs0O6zU0nW6ANns/N+wZXUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=goMoae3ppqyZMeu8jcSc/0uCcaq2LN77/XFHqFiOsRVGCrA7BDC+4cV4OSiw+yTeCbFXe4/57LCK2gI8PoZJ3iENA2w2shqmZ9a84HJ7LcsNQPHbiytTLMlzNDpa+Bsg4TZill9qpwMgqxGf0kJMdup69fYAavhzaZGmbP00vMo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:37:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:37:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jason Yan <yanaijie@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v6 6/8] scsi: libsas: use sas_phy_match_dev_addr() instead
 of open coded
Thread-Topic: [PATCH v6 6/8] scsi: libsas: use sas_phy_match_dev_addr()
 instead of open coded
Thread-Index: AQHY0wUpVWTOoZhOT028T61cMLt0Ig==
Date:   Wed, 28 Sep 2022 07:37:40 +0000
Message-ID: <PH0PR04MB7416A33E2C14E0357D987A359B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-7-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6726:EE_
x-ms-office365-filtering-correlation-id: 21c3606c-90ca-483f-f445-08daa12452d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lS8/LH+jHniUQQy1NSoIRr8SPr8u59WJ2H/3ZArwUraDPviXKwz6jGsnlxHFeybgdS6NWXoEfptKSG0eZvNjp68BHmeTc2BV5Oc8ZEZjG3JgX1L9R4WLr1mNUhxit20YwRj8yL7LZdtOgJGcm0dY0VcRrEQPEsSoPzdlirVsMfWCT3mhsiRkoij4VFNqNcg84aavHO22q9WuzUTIGs1+pUnKdwrgOE9HsQ0JjEV8GlVdsrGifkUqL2q+oxiVQTzZl1ycXns6nU6wHiO+bHHqA4hc7VjOgtWbVVePAhDHHp7nRYfiU0AENn/O5JvQzqWsWtu+hoCUnR6eLG+3YjeVHyxp8IWKbUbrksBS0GUQxK/ja1cR6GVnMgYfWLqpbKrru5MjuiIdB9fbyZldNX7ems50gsuq8oWUogqkA/Nmybk68gsRRZjSqf5NqJu6xdiObXg1fvLhs6q8vR1zZI8IHLXmJ3FKsHPkwrDh8jKuyAVTP5jXeGS6M11KNkTEX8uJdxY+En5sGd7IiPQJ+EcPZHGljHub3YNV5io3EZ1IpwImhk5T7y3XlrZQdLp2aC5sEPs6H92/VzdE0NHY+XqgL0e7XuM89e/lw6/7cgpJBNd6JChzEJxxAr3SCvG2hKcTZojySBAe3r2soeLOSMM10/tf21mGbSOXPmSTWzq/qzmVC6fojV6Z2HVAfb+Zr8z4eHa6Ktc+CC94RI+ZUu+kbWuMG/iPa6J8rDEgBuQUpLfd8lhG8oDs1WnaGWig38E3I19iOXny6s2vJlQxRNbgcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(5660300002)(9686003)(6506007)(52536014)(7696005)(19618925003)(8936002)(33656002)(71200400001)(41300700001)(558084003)(38100700002)(82960400001)(186003)(2906002)(4270600006)(38070700005)(122000001)(7416002)(86362001)(55016003)(54906003)(316002)(4326008)(91956017)(64756008)(76116006)(66946007)(478600001)(66446008)(66476007)(66556008)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5kNSXoUlblGxuB9eTypEwMuzUdUaQz8h0FKHyfMRuW6TwcWZW8/AhSrg1qtJ?=
 =?us-ascii?Q?9R8xoAdxyi5yr4vJo+weOQYqH6tXq2Dn3SGs0o5s4aWz7Uq2bX3iV34nOEGr?=
 =?us-ascii?Q?R+lkP70oIOxwen1fFD8XnzzVtJIqJ0+Rny5BXkYU/Br9nT7Qj2VQo6N0wGSj?=
 =?us-ascii?Q?VzYl0txfU1TG923QnTAeeZ28fLaCN5uP1VeKtZeUnhMI6ZXU/9UusuYaBJoE?=
 =?us-ascii?Q?aKGeE//QOIsMsl2qbtzTtSf5Zxvyr7TTZ5aU0SokcCqmPOZs6AObvyHhhOJM?=
 =?us-ascii?Q?rXkDzliBghUyY9C10hmV3RSBJov2bkCOh4mghtPCmIhgGrqXEVQRjPCvj/8X?=
 =?us-ascii?Q?PywfOMaSH0n2csF44ZO8wwpW+u8qTjlC6jL7nWrEg8wKftihT3LQAiJM9xyZ?=
 =?us-ascii?Q?J4UvpWSmlFdodKfESmViulC7/rjYz8FYLS9GMjEJCmvS8mTgVD7X89ed1TBG?=
 =?us-ascii?Q?e2jyZ1j9rDRde7c37WMcfwuVvzhbKmluOhTMKAanFZlcYyfmqN8kAqLF+KSs?=
 =?us-ascii?Q?tWBP1+ZqAdwlQvUJczIzQkfL4GxDmHG6HktLHtkFOlY7Xc8g+vn/oT/wXmUq?=
 =?us-ascii?Q?K4oBaPhbcQrHIs61SQrbDkR2TxdR9uM+Brof8f1BS5rOQuX/lcgp0SEWt9U8?=
 =?us-ascii?Q?IkaQbGoSJbQRs2pF3CbuKu3zKFK30oRFFoIpa2ortRLsaMmF6EfdahvN3yP8?=
 =?us-ascii?Q?1XXPrQe+o3DB1p5KK0RJfSOmfyV9qIylxca6WF8crw6HxipFwJgv3cOOgn1Q?=
 =?us-ascii?Q?vG/S8x5Td9WYlajDpAMWp1NKwDd2x6zg1yTD8mAMtq6TtgNeL3De+NiDS0BF?=
 =?us-ascii?Q?01luuxlpmfUkxKzatUdipq7evWcrNIwaYIVGRsukBIZRRB1dMGBUPoGRmnnO?=
 =?us-ascii?Q?gOJNK2DN3fhtXrNMCBld2SKEWMQ8doU4tuZOLv5oJivKfb1Mlly9gl/MIZ8F?=
 =?us-ascii?Q?fBS0FHNY8bhRBjksfFTss/rVbZkhBPSMV4IBRrUkquuTAo37x6oOGSNNeFsZ?=
 =?us-ascii?Q?sJL9s3lVVS4/Pz8UgznVB2YChY37qZ2Ks1+4f9kgG3/JziOPzkzc4uHpc2+9?=
 =?us-ascii?Q?XzBMusxNeuF+eU1tYpGdjVgsuz13fpw0uTUaex8gbQvj5ArLPbBF1YDEofJR?=
 =?us-ascii?Q?eOkSdwRvAKemduHAs6FByHdvoyUwyj/A1ls91PmGqRwww43QWIDqqUYIXo99?=
 =?us-ascii?Q?eELFGcuGONmsxanfvCHMrMhOiPxup6geiB07voe6H8+XtyZWL+Vs6xYCEsND?=
 =?us-ascii?Q?owek9cLrGBlw/Il2bBhVAdY+dQNyuPxR7yoW+iSrxbAqygz2TRmwBwjlLI2p?=
 =?us-ascii?Q?vu8QKrG6M7c1hmG6hwV0gFdD/6xyD8jSKIOjf2kGoZGRR9j6ZoIVzJcU/Qgd?=
 =?us-ascii?Q?0b9ixUoVN+uGyLUEBLWxMWIYSaQlq9WCdRVMzvEy1Ybmj3AUMBSCmOItZ2Me?=
 =?us-ascii?Q?BMQf1c5gkNLt4e7DtmTpFoW50lKvyv09ek1duznTnN04bQLmRaevbVimZgD/?=
 =?us-ascii?Q?bQWq9RhULgcCNcAHM7ivVKTT0oX5gcSSwyGz6RVySx2+rZ8TlL2nfPiI1R2N?=
 =?us-ascii?Q?IsXr7DNjzLmRYDSLwaGa+i2S9KwQTvn9bpOby3VYlI3x2AP9oAKaFHNrtGf2?=
 =?us-ascii?Q?drsuu7CqA0PZM+OdzlF1pBP8yCTnehjIJjBouMpkxHLXpMorn8tgP1C1l3fL?=
 =?us-ascii?Q?2PEIsyfVaXDeJiG/90iC3mAm3Ik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c3606c-90ca-483f-f445-08daa12452d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:37:40.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgdv8j3GF4ySs8Yaza+4FrBj51Dbe9R0ILjhvPErGl+h3CsQK2tMhmK1i5R/gCYkFIPf496pf265CiADJR9OelIVnWEQVprtfLMl7as0NDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6726
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
