Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0495ED61D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiI1HbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiI1HbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:31:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35853ED5F1;
        Wed, 28 Sep 2022 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350245; x=1695886245;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=L6fEEwLJfc29xZEjPG20xIpDSZl4ZTT+/3imHt1W2J8tyKdmDLhVcPvP
   kxKEr+dkz75xPJFH7v2kPS0Da2mkqohu+RQe49s94MT02xDAMhH1v2q2k
   pLaRJfM6TKOMo9ngX+p/SL1YZI9bTNOUlhnuwsQZhR59pKqq1bY+0QMxM
   +vcLD3xml+J0b+PAheFcaVFr+C2S5l05Hu4kMkPXjcwoJptkdCJTDY6+Q
   ZT8lRCAfQdVPwtIXROtz8oBDhCxkFZ0hV06aXahf6jjr7euELjXbApetv
   tOpX2xu5xIT5QGaRuBrqv2taKsuvA6cMWDttkxHAPJM7x3rovD87AqiD2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217644580"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:27:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDl+lo9hZDlO+Yw410jFPB5v4feEt9YjD6YHTwmkG2oVVDLgVkniTfm9xa87CAgAP3/WUh/nVOv5lt7DTxxmOGrMS+UOgijPDODAWbYyzYP9NqSoIWt8rhu/AXKkV0u7JknOBgwVwrimRTMd+HdXqUBCB6d5hBxPvOiL4L9CGK68fC1qSwOGtetXHyIPJtJFbAcvyzQfp7c/Dl5knyua23vkYNTgBNgixkM3Exk8jnpoiOtPpSbUtoqF8qtyX+0YK2lCovm3rb7TOutNdKTYoOUek5eFRlvXJ884ZeYq/OsNBiSzLvIUXWN2uVwjJhwsv2l8HWLCb6sb5s2oKO/hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Fze8mZyB+wv+/8D2fOzskUC8LBGHY+KPnP96HJzrObw/UoWnrfeLVogI0IzAShPiv0e0JwBuj/RyYi30Jc+GQBa3Rb1qEpPugYMDZ1dKeFLW9qNU1tD9lBHe/XjEyrrJbEidR0NloFW3SL2nXEAWKssJgVgiRSvsHc4BUSNVJg801OvyAY7m0LH2g9uOakiGbkafk0xNi/9U+m6xc/IVqy8Jl9V51wT1WVzY2uiAOr/8qrAK3eo/3Nq9ORF3PEfVbUN5FaObYFeoDWXbp4rJUHxG6oNYHRkEqHqnBOqyanR7F9Rfnn/kDIwyIwuaa+kFSO7lTp9tB5K7Mx4aFPmLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=uF6rBOSQz8A0RHLLOo9MID74a5XdC2E2JdC6kfqsvQCZNtsqkmxm3wUTJ2aRPHuWDXSBzHZdkP8MTKDLLUPSP23l4KCGiD16QQLDmHwV7Funcae8FshpzWUwVCey/DzgE8pkP5mSIuTD9UtL9jGHRM5KZcafYZOGFbRmQ1RcmjI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4487.namprd04.prod.outlook.com (2603:10b6:a03:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 07:27:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:27:49 +0000
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
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [PATCH v6 5/8] scsi: hisi_sas: use sas_find_attathed_phy_id()
 instead of open coded
Thread-Topic: [PATCH v6 5/8] scsi: hisi_sas: use sas_find_attathed_phy_id()
 instead of open coded
Thread-Index: AQHY0wUmFVPtLKYf7UCFf5SPLAObJg==
Date:   Wed, 28 Sep 2022 07:27:49 +0000
Message-ID: <PH0PR04MB741606199FD37F7EC07198E59B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-6-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4487:EE_
x-ms-office365-filtering-correlation-id: 76494b7a-dfdf-42fb-2f85-08daa122f28a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CpEgGldRDOojycT3xJm7tFbYwaBMfmTZ0m/7wn/y8V6MePOXswgsxYOPlceOaAUJFqtThnaXJssceg1LJTU7FjPIKYWIUPk/3DxLpQzHgQPu6hf9CaD0KMgXSKVYYvy6RAINK+98S7cy8yG2kOGTl2VciiVb1oskgAoKtj+4tWXWLvgwTg0qRc5jXqGXPoXDV1+/wPgS5csBKGSxrY2iuW7qFaaxeYPR3a/tCB4wG4AYEb33RCSuBy36F0be8cKxKUeOtylw+zT4Xqc5siFK5m0sLmYs3606yzLWWqI5QFRpU7PdQrhkfJ9CFmcm5p4AYFVtma9gT518CNEsjUWn/bCYfStaRVW4cl/4j5Pv8AZvkFPl/NbNBkFMwWbNTcdNPIVF5jMIJz70FYN+dtik3O6yXgkKvCABpGag3W0mPFIjwjPLsaT6PmoeEv1aig2KEBfFoA95DkKo6mhnBZCcNff4iGsmmqjkuQhUMSjsYXeUpGY3qCtlDZJ5gL82deKauPCFG7gwmRxyHryn02uDNWKU9UQUii30IuXX7JgpzLq+aS+MqeX0PaxZGU7c7U7cVrRLQMR0/v++bssDVyICOZ6f9PK+Zchmb8ZQmuzeNeoE5AYQ2+Q1Ht8K6sBX338ATvaph7kYHidNfTgpYIbaQ0LMsSJTZM6eLUu3twKzABQNQoaWhVhruGyl/IensV3RblEcKPHk1bPCuSqGVYwsreuMS3G7BYE/CbZMas0cccYyOqWPBkcUULb3RBwzOopD65YyLxKV4J4bnCQGGCzvlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(71200400001)(55016003)(86362001)(110136005)(316002)(54906003)(66946007)(7696005)(9686003)(82960400001)(8936002)(52536014)(2906002)(19618925003)(33656002)(8676002)(66446008)(64756008)(4326008)(6506007)(91956017)(38070700005)(478600001)(66556008)(66476007)(76116006)(186003)(41300700001)(5660300002)(38100700002)(122000001)(4270600006)(7416002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fLJ1/xs/ZHShQlhpIJGPDGyIWMsEW6ORKCSjcysu0hZM8qSQVtcPt4eYVDzh?=
 =?us-ascii?Q?X5REyeuAbGYGKIi1LGuccGEpq3Q2Fj4kdyzmZQMaCtYRj0S8FXDFOUWEPLPx?=
 =?us-ascii?Q?ataxKdNP/Qh9Tw13MBEc3tOhoR2mWRDzcNa+Ky3RXB7NiNXl7xo2ofdbw2wr?=
 =?us-ascii?Q?KbvcvGpkXPoW9RNZgsT4XPUbMbYKG7Rq2KKLbu0HXp4rs8sLAECNX6oIXYrG?=
 =?us-ascii?Q?IGyM4dROOejYRi12vEuMwCj8Hk05KVliKxhhlO7lo/ZGAxPahKdgUPhAWQsR?=
 =?us-ascii?Q?jyCd5wO2DrmxmPvYPM+GpPNyMxVVB5D+GHV0Nib8b+kPxAMyEJjCUptDeHkz?=
 =?us-ascii?Q?OgA6x9x6GRTkquSNGSq8zFe4QJmiBtVSI9YF85Dl0ZDGTMTxfJSRq3bHJkZT?=
 =?us-ascii?Q?l8Undtl4N92bGQYXHxDH+3iDreypNbtxSPIyPTqCJEUpoQ03/l6lEhyTDycQ?=
 =?us-ascii?Q?JIIlp1uxGIP0UsLBwhLifa+GeiUSlx4nQL87d2C/GptRAWplD0Ygej4Gytu3?=
 =?us-ascii?Q?yV59VFlNjA8c+gVBaz8BR3QxiBKCGcPg+Iq64oA9pNMpFnWFvQIQT9xax9L1?=
 =?us-ascii?Q?j6WVNOWTxBWNMmutZMHQ4jq/GH8PsGj93zvu6Q1OitEm4weCWtbGyoALDBaI?=
 =?us-ascii?Q?55n+1CrA1VOvOS7CkD/dSS/OhSKTGpgt4YaPzIiVogGZOJeXo+FoaUVw7Pna?=
 =?us-ascii?Q?XeSVwstd/4xLOsqJjmYYQhglqKjUkyEeeri8Sgp/Og3MoylMpLuaLhkedu3Z?=
 =?us-ascii?Q?npMwn5eDqAGHh0/IxnpQRoRm/9l5uIe5NNUHc0SMl53N/hhwnY6VOFBuw59U?=
 =?us-ascii?Q?QmR5UoX6OlLa+9CGnkAoKJkHdA98cpan6AGli+pO0EkxnY3z3iB92cw8jnTX?=
 =?us-ascii?Q?PuB09sxIJVo1MVa5TMcxkFofbs8E69IqDog1ogrYo0Z1Kz8eHtVnro1nj/hy?=
 =?us-ascii?Q?w5TyLIgXRAwN7HqLl+VvkwVmM3rTWEJuZdqrp64GsPq6NoOX5tuwbvO7b9LN?=
 =?us-ascii?Q?4nS2VC73wTDM/5cdus1E5fHjO9ydT8b3YfBp9xi/Ys5e0wFK9JGJKEbdNeJ9?=
 =?us-ascii?Q?cxzrnjXUTQduQDribLk6p1hTNDrZ1IhK8aNmdq4eOY+nsDBv3vxO1sPgjFEp?=
 =?us-ascii?Q?yd1UBx2vn7Fl/RA3RYUYPh+2sgwkbyFoYL4Z07so4sEdP/isXEeIQUvtJcIu?=
 =?us-ascii?Q?uVUD+W0dueS1CA7sCaxZX4N1GZ2rTXY0YYHxpCbLym23/ckk87baYwz2Va4z?=
 =?us-ascii?Q?Jh4bibAHnki/9zPorJYUBLnEd0Cn7rcSrhR/HPJXEHSn439PCmc6Kclf7DE6?=
 =?us-ascii?Q?Lv44gmusIaroXatEKvG7VVPkdDBNLPrzavscfUNEGRe7al3e5oJ4mnK51WdK?=
 =?us-ascii?Q?x7jtkW/nelbZ6vqdlymWMKFazXE5gViXFrBirZlSIHma3pZJBQTAsFD7coal?=
 =?us-ascii?Q?gtljgkajsnfgk6dZuMO20nuFgL5RbUGrLexKVEX86q54AF1msP1BSSOAV2T7?=
 =?us-ascii?Q?OB5ddh0lmyCFFBDPavTR30Mbb/+ylwXiQzbzeI+Qwb0S0SFGZmdiNNZLJuQJ?=
 =?us-ascii?Q?cgCR4hhGiOiD58c9qb/X0GqRjOei7CHBPcOLW54RO+H8I5A5gh3D7EihFCU0?=
 =?us-ascii?Q?sm5DhXR1n8kcnsTh3mzSFzAL4zr4rmaNwIXE7Bv+rRULdcewZcsPnbFKCO0T?=
 =?us-ascii?Q?cEUpXLsTNvykX4ciUxn3W1SPL0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76494b7a-dfdf-42fb-2f85-08daa122f28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:27:49.6292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVNy2OLu5aAeJHdkeO5heJsVwuVWMaVn1qEPaukncUB99UIYH1KMU5N5qar9zmM3r4Nnl0m6H7BJN0Kju4Z66rFVGRSZ/iOsvHeiYCDF1bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4487
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
