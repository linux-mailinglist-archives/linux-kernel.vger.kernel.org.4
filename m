Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611035ED67E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiI1Hk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI1Hj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:39:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34840110EE4;
        Wed, 28 Sep 2022 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350691; x=1695886691;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rpOi0Q2ALpGwzM/TFxK8texThSRml1GCO/xsNenobts9GiYBOrLawve7
   Gc5dd1dU1baVDxraa91TxQEw/BAbsJDIJAxmnSrbNDAupxKwA/O60hAXs
   IPMN/10MnH4BiqMfbyh1TnyERLb/6xohcSgi5mnoE1TB/P6Q6ZISSDEFL
   Fl/cjt18zWbguVpqlhAkoeDcJK6BiEtE9phSD+zZ6z94QuqwysuS3/B8Y
   fbkojoZqdqWyw1WpOh4Znctqu/2hRa6DmMYmyZj5uy3KWQxwnLSLNj1cV
   4H+VJysofQ25/ftLJAnWhBht0a5y9Y2WO9kM/oEw/QYOD8aTgn9IYfQ/V
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="210828496"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:38:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9wV5BpB5br1lpl7eBrDyI3K1SYcnmqnkJMzbyxxdROrNCRD5DfI6a+OcA6KpCUOFD7CYK7tAgHJa0ookxTKnnUOTZmJZVvUrh1Rnb+8N5A1nubt4qmGtXYVqxrIxPavLQSlZLWNRqYE8cMblWhgjYkvXi5zrGBzJw/NW7q+0pFpcuqLNVJMO6TAXkt98h5jt41EKOi98QfiaSYvyh6rrFMpsxBoGndhODsfMTVJsuhU1OYXBOU7a+LKXJPE2TkcxWnP+EPToGlVIV7YUE2ufborhuESeuI6ZjbHlx/vw/pZc7X3smAQyoh43UfKWNPUGyUXI79/m0yn5g+iJRLuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Es2CeZ0Mu488FYmrhlACYiIM9b5xVcv3Vd5FSVUCLyp05i9MrLc7+kicZSlxsnaaQ01vgdqoZ+mMi89xfLG6rhEaj0UJYz1AyN3ohWwnvMqht6+mg60+W6cYzJdp80/DULMAhgcao7ZgJzJZA4rVTFpnNXXNZsYecl+g4ll1cbI9JmiYVtwNFMiPbaffvhCZ/1ZtoCm+ts0Y1EVN/LyJIofYkVAi8UZDv9jf+TCr6HmBUD8iP2OL3/Zmvda118yGeW9QiNWNFVVQsVBB/GYtofp53+/5jr6YLOE9VM4yr7ilHYI2WLHOmANlbA5CRzg2KSw7S/b4B4OMMmcNviG+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PutPtMw5E/IS0Pjr/opngLvcmbU5ul9OMHjmqaEwuhPJxHCaBbu4uxx43YloNll+dB7Pngo15RKnTg/AkUOcA7Wi4rw6BkGnL6skDkW99NUTK5l2pOixFG2vpDefqquWxfkTWXE0Grl/Cnttuxc4dSvILPw+3Etya2jM9TozxmQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:38:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:38:04 +0000
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
Subject: Re: [PATCH v6 7/8] scsi: libsas: use sas_phy_addr_match() instead of
 open coded
Thread-Topic: [PATCH v6 7/8] scsi: libsas: use sas_phy_addr_match() instead of
 open coded
Thread-Index: AQHY0wUnAh0uUfeKjEiR0ss/3vkCVg==
Date:   Wed, 28 Sep 2022 07:38:04 +0000
Message-ID: <PH0PR04MB741671B26A068C3AC85E26BD9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-8-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6726:EE_
x-ms-office365-filtering-correlation-id: 84f414b5-5e9a-4e07-2b3b-08daa12460eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EctweuLpH8jKVZIDwnCxIqzedsVo+m/GzhNA+p/wto20Eqv1cCpGDqFhwzaxg2kgDKOcNoYtM6KBBvylD3RveanmyD8OQJLXmliVgVodAAfJbBBhUgILSDasC/R/iv5HzOrQixfkjClavPg35Orn62yxRkU5MXnce4+OL6v1j8CzugOcgJchb91MPeV1uZsZ8nAjJ81Toud6lAm3Fhm5zMV9OV5pu6KAvnQIv6bZX0BhyFSKsl7UckWV348d73uOLbUzwxDntdonGVuNlmztV/2X98DtA+hrGH0axi5pdAmaF9ZDKu7jdMqv0zeGQpJBHEhnxmVRgbGn0Pi6BavMIruCpONzbkGbHR90aHNYMY70NED1eAQVf6oD7LXuO7v/eOKl+8rpj0BWlUfWrjZvsZYHhbpZZbvcIBM8ONYOq/MphZqzg1LXm87cZsMuGHEl1UktQxDj6v3/ssyPmWSJokbyxIr6cZiorGLZStOz2KbNn7QmX99QujBjDoet9zQKYqiavO87CkZBlpkIciZyL0l1xnpbc9fRkPepaTAbm247XIjF8V57PABqFy16qvS/DjCrbvDExI2ZmCM6ljiwLzcG3vIFk+X9N3bBKji9T1vcQmiVENqV4FHNX5dSgwWshidpG+H4HErYrmlp4Zcf4ivTD1ccwJBl3OE+4fBKltRW2kuHr0I6lGAyaV6FQiOKHbgT4JeZK0VJqb50CC1FQEmWQkI/gfH0X1J/+iSHf1unLx0JsfWETRBumT4iQoIegG7lOToh7iszK4pe6AOt2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(5660300002)(9686003)(6506007)(52536014)(7696005)(19618925003)(8936002)(33656002)(71200400001)(41300700001)(558084003)(38100700002)(82960400001)(186003)(2906002)(4270600006)(38070700005)(122000001)(7416002)(86362001)(55016003)(54906003)(316002)(4326008)(91956017)(64756008)(76116006)(66946007)(478600001)(66446008)(66476007)(66556008)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3KxXYjIC25TCYN2SkASba6h3/xUINQApqhZf79TxHMvyy/o1fym1+H4CsJnk?=
 =?us-ascii?Q?/h6xk9Z8vuedfsV3ICqdprvMVQP134/pJu5BcozRyiXb1Re+1xU8QF7+5cR0?=
 =?us-ascii?Q?JmFW+BlejJNIY3JERc0dlQBsN76vwoRwvt56OdjdOS5vm38VDvt/isWAftOK?=
 =?us-ascii?Q?Hh68izbHbAHiTc/grMtNF7ev0dReM44dgq0EzSTYTKcQDFF5udpFFCWavIRW?=
 =?us-ascii?Q?nkKmE3sfanw8r3rMNtFr63G+mmoaCZJ7XRUhht/U2VuCMQWLYGDTQwEjvyvX?=
 =?us-ascii?Q?+0V72h74nuImcPihmAe5tAGgAh/BptzvbEKmPOoUzqt5meeMNXpUuk0qdTwN?=
 =?us-ascii?Q?QXz5XMPVgL9cOguPxk/xY+xeSIP1zh2nH2VhSAXmLbu9U/slY2dU7QBnjUxW?=
 =?us-ascii?Q?eLsxJHELE/gXZDGH9TgpQtxl7E4Cx4pOlaSYIAUZ26UmD2O7u8ocbdXQEMJy?=
 =?us-ascii?Q?AElXSkB3hGUkNEeHUjDrX5PymAdZmAN85RjilsDQB4XtHdRXvuYdFqwcZn0Y?=
 =?us-ascii?Q?zgWWrxWJCp2aomDLA9x8DFkRKtwh1zZxH5b7cVsegKknIob05lh3R8e2imO9?=
 =?us-ascii?Q?qpLuKNX5lq+ZVJMtn2BIiKc8vM7Z4SzQbae7BMB5KYwrX87bRY7VT/hw0MS3?=
 =?us-ascii?Q?LC0h+8UGCxZpUSRlU4/rv+tBPDnC97ZdoPjS6r++i8wxAc3qcjOnUxOrGgxO?=
 =?us-ascii?Q?+m9EWZMxQ/vQIVPHZTWrpOiB4V9is5iX9PpbqMMnihpABUekiV2tZzYCgeiP?=
 =?us-ascii?Q?bx51SulmVXXcX+i6COFx1gb1chOVAgJ+RUzhriR2uMGXDw1c2oUMLwXRK9OW?=
 =?us-ascii?Q?kwdTAsy0fbh0N7mW4S37j81j/YLZpzeoQfzbViN4MG+5uiJNncnHF7amKB4U?=
 =?us-ascii?Q?ta8vuFF3iusddV0iG+kJGDQTfo7g5YhUrUG/lWmG4XG2EyBh4OphWZfjJwlo?=
 =?us-ascii?Q?/Z/WYgsgCssx782p5I2qUbII0C0O5ha4/s2VyiJqkbRXauqTmX28Q3NLmw1T?=
 =?us-ascii?Q?IjzhPeId/v23oznO9o1y+mYWdokH/eWFpkpr1jDR5mUjHogRpJmM17jkmLXr?=
 =?us-ascii?Q?FhSq19LzQvKmGRsEzPC8NBmeyd/OHJN0J/NoZSW6mHEZbE3Khe2FlWP82B+K?=
 =?us-ascii?Q?0SpXIBbBJkKd7ZD/rZailJahmuJrHVMDcgIWFDJCWG60hAdyRIun6W5/VjHB?=
 =?us-ascii?Q?OY10RADbjyk80A83RpFVvfiEXTJVRDX/y+N8dxet1rXItuOf3CFf5htm141M?=
 =?us-ascii?Q?nHHEEYM6K6GSS/tQJsItmC3dp0O6FSWA0prIrARYk5D0Gn+DXcVL6RAAOVPr?=
 =?us-ascii?Q?bpEHLRpG90d1bNf99t1/gOn2oaw3vYct/ITEGmeZmpEXovubLRFsbROAc81k?=
 =?us-ascii?Q?QNzL5UI2a3yAVb/Fk5LGO119Ok6UBg9BvuncTodQksODSJwYYDlrWg6GNWGq?=
 =?us-ascii?Q?U5DKjgKzxjlThG0PjC0AQGVVsFluSSM+LGXT52HiNK0K2a/Ukb12M7PIy+aj?=
 =?us-ascii?Q?TVvtSSk+uC0yd6llcIchgnXF00kqa2YpxzaEirNn+vmKHE21Vdws7PhWbgxs?=
 =?us-ascii?Q?bj2/bxitffb1jCBL4ynPNxl9yOVCEgHu2tZlDFwU62Jmi8R4mRSxquGELFaH?=
 =?us-ascii?Q?0DLSsFfRKdHNt753FiJBQScdnqrRlh5+PUaS0IxHyYvTdtx9Cdk6Yve8pMr9?=
 =?us-ascii?Q?KnIAVeo/WrTWARPbqiR4Sco2Ovs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f414b5-5e9a-4e07-2b3b-08daa12460eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:38:04.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pH1oHwBVcxsO/rmNuXSq3MG5cihapYrQN0nsKha7XvJo2aN7BnsLZyfu9JGwzSzF63buN7VEXVeD2UFRmOIWXqyixn0SNBM9rzCZx9baIg=
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
