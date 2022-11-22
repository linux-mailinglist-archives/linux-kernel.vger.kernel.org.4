Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F21633BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiKVLzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKVLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:55:31 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1796D252BF;
        Tue, 22 Nov 2022 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669118130; x=1700654130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=84P835JY2RuElB57/yRhIP9mxIIw6lAE8tAm+Ru8ioI=;
  b=b8IzYHLG8TbZAYiPcrffIQ8Av/VOhwF9JReWZa270LHU1dMC+gJK76+h
   g/x0m8Cx6q/0BfkWZmH0aAGhEWvOzhHE7nKi0+mz0JYL1tqTWWluUWEGk
   rIYXGtGKsqsz8DmzSgyFFkIbCEisXadS8CBjFIeDcMg6kezXC/hlXiWyE
   QpRrj0RFCc9VQx/VTdh1wx1SxovKyZ0toela8drnZeEM6E1K+3FCr3Et1
   IRqxt+BjkuiWHyekUvQm6coejsRCstGOI+iyzhHbRdc9R7RCoWQFJCp8J
   xAIliLiKl0IAHoO+gXZlH1MKcCo20yQiHvmrNatVBdlJGrrZy4/MDcWX2
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="328988743"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 19:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1df7XA9whMnRhxIdwBoyK+1wsgT4lfjJtDDHfHzaIAKjhlWYohk20LFetkoBDNRiI7SlJtwDvBVC6ox12d/Alh6DCc6VaEHVXKWuppsYDkTiSiXA+qJCEMEHmqy9Y1SqY8wl5oMkAAtcAGBO9EtbwRZBEPVdAf98M5LApnGzni0RJqlQWmZwGgYXmDLIMPfjcLLquzShtVFBUrmizX9ktLOdWlF9Xd2DCMmOvjD8B6ewkSEz830yQ6PpdAlxjem6fJqh5KS3WXFBjjJyoYUgq5tE4F6Re/IfQO176Fxz1mSa9DArDaCBUJy/iiELImtR8MnL3FShSxHtE+sVD8bSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcJul35JPWAiqqm9JMvN/b0X74GRgcz5r4jQd8Ya4yk=;
 b=QWya20ssBmFs2fBYfTv//VzUGFiq1xWGEYnQMBIAIU/EI5D9pTaOECnnyCfg0ImUtp4yVz1OMQbDAZpHZ4EjyjliqJpj6Uz6nbl2HzN4KH58ieA7rwVLEZjWP4MOph+iV+oDMudG9dlk/GLEeaiz62Nyh/haKW4XVZybOq9l5fTGKEho9Sue6fGX+/g9LqBAx5C8tHr5I+FiPswes0TBobMIl+TYmJ0Jr4x8cD44hc6dWGiOug5wI2Mnc/aYAUdE+IZ1u6SYqaOvHVJ/HpmEEXtyDV6g9kd49tzAAP8+ApRrBbBquP6MYXgRV8CiwN+r39Jk7tUcJzM72dlSThUZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcJul35JPWAiqqm9JMvN/b0X74GRgcz5r4jQd8Ya4yk=;
 b=xxcFcdrGw4vDuOT0nvS4gUicHKffUNU5CbhxvVd93fAIFqBZHvXb1JkKqRZRsvIMqg6IJCLc+Bitwbn7LL/1gZGDZZJRnmmGb54yuAPCb75iFs+zrhwQZ9TsQgL91Bw/PkbnAVB8we+R4BV/zVBc7yfG8pNUvG4FFkE+w6p85fY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL0PR04MB4611.namprd04.prod.outlook.com (2603:10b6:208:4f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Tue, 22 Nov 2022 11:55:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:55:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Topic: [PATCH v2 6/6] ufs: core: Add advanced RPMB support in ufs_bsg
Thread-Index: AQHY/S6fGNUnGplQxEOfi3uFlr5Rnq5K1fvQ
Date:   Tue, 22 Nov 2022 11:55:27 +0000
Message-ID: <DM6PR04MB6575750D9C6F84FC3BE06AFBFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-7-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-7-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL0PR04MB4611:EE_
x-ms-office365-filtering-correlation-id: 298d6502-3c4c-4831-a94a-08dacc807286
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOGZPeQ5zExW2y1kXCjJqZaaXOZXCeCZIatDBI5Ic7wcSd3rmCQSJWw5vqw6SrvUUodRZgNyWq3xcAENl5sUA8KoY6C3vcwc5H2WLJGe1DW9vf6PWaxQK6NlgtzBPaI5pXCFRhkxGQNW5DFsYMS0pJG3zepIGVbVipJfr0l0xAgZOLjJv0Z/qXBB3K5FQolxwb34UD9YYx35huWlKAi+Q2g/WQh6b3sXU8l5bghiVoh5KrgEkV1WKxXSl/j8Y7ervNbtKsMFL6KlO+r+xoFVizPlvXF6H3jnDCUQzy5FDAyFbNrHcZteFCrf6w6YAWlfOthEWST3saXhuKQGtMzveQGQCGHigNt/+XSyOi/Fxr8gdntjB9yf0TqjMTcYYqyTilfFCa87SzjJj0hwjJrJJqGLMBKXrdzdiFEO85Ihge6HfwHGa9HjVprxCBMsxsDT+1bE7ojXRWejdoE9bQVr85+96Ay49bH8PBzC/38Pk4Fl8gq/qxmJu6hPPSAu41Ez8BcRnP6x+gx4U3hoC0sIATwVIdpH0uGsNIDbXKu4s5XfZWA7fzD4brGu6t9h7ZX7/zRkO3hLQSCaGkqGSqDmgShZXIGHQW76KLIrJwHJsdAnbH0w2Irs+VUzp34s16r5Q26HE3SrtItM6UU+hkWVE7xO6KPTFJx2EP/pv81BpOd7djeUd9Auzr/E6od2JvEEvDhba1Apjd/TxIHZJWhQoqr2i659FXU7hpf81+Fqorc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(55016003)(2906002)(921005)(478600001)(71200400001)(86362001)(54906003)(83380400001)(7696005)(9686003)(122000001)(38100700002)(6506007)(33656002)(82960400001)(186003)(26005)(110136005)(7416002)(8936002)(4744005)(5660300002)(316002)(38070700005)(66446008)(66946007)(76116006)(66556008)(64756008)(52536014)(8676002)(4326008)(66476007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2CXhvY2hg3RMTKJezz72taenSs+WAZM19r05t1lDRcjAgizBrwGV6REy2Z?=
 =?iso-8859-1?Q?rUpRRf8hYcWBc4bkhzdcbaVuL+oHE2wROmZm12FZv6t3t97pjvOqSF412W?=
 =?iso-8859-1?Q?9vSiLRasWgZtKMdXEkQ+ifiJDYBL/C7aU2k1zTTGaOFcy2ClwhmBW9IQU3?=
 =?iso-8859-1?Q?a6a2dzhQpgO4nKDLw+uL9oBNHKYjxnDu/lUQg2m9Pn6a5TRBlzaCRSjiFw?=
 =?iso-8859-1?Q?Q1xQdQEJXG3tSsnRH8WQxUdh+KQfPd9ZGigdxBpjkkY9yikWQqNnYathAv?=
 =?iso-8859-1?Q?8RNqdLQNfo36K+s1xCCfG6gSK5CqGiW/2UYYGdGXdlx21YX3rwtOfSaAZn?=
 =?iso-8859-1?Q?tIDVNpplaUzdumWDaJjER3qQWYIuGdO1QL/C0jJ4EYDXd0cjFON0C9mrcO?=
 =?iso-8859-1?Q?uhXV7PJo9+TpoGD7HFuAfRU/ruzBw6uhV64IygqR/1pSJJ6gc7uu0Hpj3J?=
 =?iso-8859-1?Q?J4rjifGnShqZjznkPGj/kDAH+Kd3a5dgFccBp0D6Z+Vqh1vngME0RvXDq+?=
 =?iso-8859-1?Q?39YMrw57R3DAb+iM8S/NOFk9FROT2nufu3+K7T/dF5af0/4Zpz+gHJwPTy?=
 =?iso-8859-1?Q?4OZSi1LXXKnhe57Brzhfw154dN5l8XEx1bQWhai5DtFGxA9uVIf6j5j3tI?=
 =?iso-8859-1?Q?ArY9KJkDxlI2LndByJXjc/eBSMJM3YnqacPgCWQq0NHywa9WFR7fqjcgRi?=
 =?iso-8859-1?Q?3g2AYimMNkQmanNAQCcKQ+Q9rn2tq/Op7hc9KxbHqMXggyeIp6Gtpn4cRv?=
 =?iso-8859-1?Q?CdxAShoFpWJQ4VSaD3yrOZgkvzDNLtJp3/khDo0/q8wdiz64fklKSVQv9Y?=
 =?iso-8859-1?Q?La8I7OW9rhjvZnzSPw43kK1nv/ZsZrpXdYNSudmOlts9WJcPTqqq0+LmA1?=
 =?iso-8859-1?Q?CviKXZ0stmfvM8Lz51ZX2DGD/8CtRNg0OkgvosQK9G6cQGHoJ3hkeATPL2?=
 =?iso-8859-1?Q?K6aDH6DC8JJ4hU2WO47Gb4cycQggcpgqSyxSLnF6MWCR+jYhOZRLF20llp?=
 =?iso-8859-1?Q?QZ8D85Nbv6PGm6jO4Gp1HNLzagYimPFgxFOhAHCyG9WVHFESP098KG9W7r?=
 =?iso-8859-1?Q?hKidC+CLP0ccwlRiG2vCFO7mmtQ7yfGAWb/PALCOj0uFtJpTBpd0cqZx/i?=
 =?iso-8859-1?Q?+2cV9fhjMCjZ1dQ/IapH/R4CEjOw+/bWa5i2lXd/M/uD6n/X1EKcHYhvcZ?=
 =?iso-8859-1?Q?tsBGwj+5OIKeg2BH+qmo0K7dXljjoAhyMy4HIK52I1xvAR5qgR9lWDglMZ?=
 =?iso-8859-1?Q?eSo9kZST7+LY65nx6pRrOcpZaRRNUg/TuVME9OKjX8RfnnKNMQtsV8LQC5?=
 =?iso-8859-1?Q?auOcd7SLXcqg/K8A3xJLbjmZmM8uwihtMcaIEe7bmqtaf6TNxqqwbdMLwU?=
 =?iso-8859-1?Q?iW15kQGAm3tK6TEW7snveuvhZGAKtol85eUln3/otiT0zJBLHfi7zjPy0D?=
 =?iso-8859-1?Q?dDbqUZea2cERxcH3LG9t71N36lwOLvGJ/ydkYO+xEj8VqDXCKim7nFJGsM?=
 =?iso-8859-1?Q?Pw3bhXPuB9Qc6n80t7IDX+cYirTVHXSnoj9cA7Pjkogl+DzwC0Trsky4c9?=
 =?iso-8859-1?Q?/hd8bmTN4LoOjGTLJsNHKxe2peXIippK9SvHqYr5NHV42cSYsOi3pvJ7/b?=
 =?iso-8859-1?Q?6+DC0PVli5AW3ZgKLSRoWT42av8AdxkHJx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?1Mt3tWOlrsrdRCwsPVQ24Ll8kPcufo+BW/0z3fcNAK//lYo8/LFMoihmPL?=
 =?iso-8859-1?Q?J9o3l8n4LVGQ70fXotG9MVeAAGycfxTNIj6vWNzmvhki6LWnioCnSJ1p+X?=
 =?iso-8859-1?Q?uXbUFp5zCaSupp8YqtsYUFZwJPE6s4UZadRQsmEULBpqsuWsp4aTin7/cA?=
 =?iso-8859-1?Q?vcVbxVkfyHZ0gMiIIvCDDJ+6EScBxjx6OOiLTEs3ixvoa7iVsqmn+JdCY5?=
 =?iso-8859-1?Q?Q1p643Z7mxHQqfs6vb+jv3kUuigXOjhx1Z4YatFN3RYwOnk/bLtrNE7TdG?=
 =?iso-8859-1?Q?px64p3uovLWjSDo6BMLJPgZHTXOkbNNVcP+xHNjvYqsvO+dP379B4l0VZV?=
 =?iso-8859-1?Q?/yS6u0schEap7pzQuFfiQDDnBTUPhvE8IR8YnOkyjeybuOBY0+jy1NEBFE?=
 =?iso-8859-1?Q?qOHSMxVkR2Zs+SQyERUwxKFGiKIS7ACIzLslW3cWPiD/qCGWmY95/BUeE7?=
 =?iso-8859-1?Q?ynO2TjBUEJ8qxjbMZYz3bTPVfmbRWRJ7fwiF84UGOIdC6cto1LLEFKWDJn?=
 =?iso-8859-1?Q?tvRQuulHwiFOD5cEJMXVuxM0Miv45Qa87EI067bVagHPGmcm5zOKHF7BKi?=
 =?iso-8859-1?Q?L7bolHW8g9WXCOzmydg3DAE0wrbi93w2ohU9rWhQ/LAdiB+Zz55B+Ic5G1?=
 =?iso-8859-1?Q?aiEZ7NB0JN/vvZ/Wpi1Dk6NzOP2tuSTwLwOqYPrudS5VHM59RrnN2UjQuz?=
 =?iso-8859-1?Q?govUkLBB/Z5VV5hmucJkoAQHC57klTicnozXXFnpLIbn1A0/JBVOMMrVz9?=
 =?iso-8859-1?Q?tunSRXcwrbs8RxR48Gyia3SWs9KH0YLSWnBmORLGXmJtX8dy2v3reghsiy?=
 =?iso-8859-1?Q?mkeQySawGiBmSDK6T0Xb3V1nKT5Ew3kC0zxf4s/zA/Lv6dTHSvcsgGBj9i?=
 =?iso-8859-1?Q?1FRMra9X6nPkc09GjnJB0lzF2eC/vG4IHLkd72kU2w09hjSDCgwI1cX2UH?=
 =?iso-8859-1?Q?mlZzdhFfikXsCqtQ4fxvM6f74to2tF/dsGz9qEqINWDfWOIKfWpiINI6Vk?=
 =?iso-8859-1?Q?RLLSoTJGBHcIVzssk14wiyYqg0bQTO93ZyzV82/EdSwi8HuWGbPbFndzza?=
 =?iso-8859-1?Q?nB87cdokf37x7iR0XsXsyJOUjPv3loOFNdW1kybycGiGRdhrP8ugrAPT50?=
 =?iso-8859-1?Q?WaFwrN6epkaPT/+PXU2mX0QKc4u5R/AKlKsegTcVnpXLTWFxDdcChwDPlv?=
 =?iso-8859-1?Q?PHZudG2dpkO1V/b8SaYa2OFTWOLNhWBDhaazP0puuoMsg/wHnE/5yPZ7GE?=
 =?iso-8859-1?Q?FJCi6Azo4o3QTDZqkAQtrwwaib3DCJ2zKM9247kQUt446bga0QRnhlYdqu?=
 =?iso-8859-1?Q?EASWuhHfQqnPKOzvgu3c6GfjKQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298d6502-3c4c-4831-a94a-08dacc807286
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 11:55:27.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4TdI4VgmCU8mKg8OgWUxXmpibD4qx9VvXwuellgTs77AnSyHA4XZ+vC7vUp8KgvY0WTrubIZkooKhU0PbLJsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4611
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ufs_bsg_exec_advanced_rpmb_req(struct ufs_hba *hba, struct
> +bsg_job *job) {
> +       struct ufs_rpmb_request *rpmb_request =3D job->request;
> +       struct ufs_rpmb_reply *rpmb_reply =3D job->reply;
> +       struct bsg_buffer *payload =3D NULL;
> +       enum dma_data_direction dir;
> +       struct scatterlist *sg_list;
> +       int rpmb_req_type;
> +       int sg_cnt;
> +       int ret;
> +       int data_len;
> +
> +       if (hba->ufs_version < ufshci_version(4, 0) || !hba-
> >dev_info.b_advanced_rpmb_en ||
> +           !(hba->capabilities & MASK_EHSLUTRD_SUPPORTED))
> +               return -EINVAL;
> +
> +       if (rpmb_request->ehs_req.length !=3D 2 || rpmb_request-
> >ehs_req.ehs_type !=3D 1)
> +               return -EINVAL;
Maybe you could also check:
In case of rpmb write, the request payload 4096 =D7 Advanced RPMB Block Cou=
nt,
And same goes for response payload for rpmb read.

Thanks,
Avri

