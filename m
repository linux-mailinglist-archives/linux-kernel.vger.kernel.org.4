Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5825ED67C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiI1Hlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1HkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:40:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17B1181E2;
        Wed, 28 Sep 2022 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664350703; x=1695886703;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aV88BIRuBCEbEwVu7/d/5P1UpedPPavkt65vn2XA7YwGZy0cc/peiYEe
   /reBlVaYVvsCgNVd+CZdJrMMXju+oXN2f3E/2qdYXF+cWJxKl1DQVoeqi
   c2nMDqJxFblOGhbm/Q+y7tMPNTfP9yD919h44w9CQ1GOidrXyYbGfUMsb
   wIiwDpT4/rd4YhmCJTWdycixmE6KRSCXAXwL57YKPdq4oYMWo2Rd2W9cH
   aH3yMABTgxDVtkk5V+BO0poe/GTu1iQSF91ma7o+VaycaypDLFZeTqg5+
   QSJIZSRACD9MoimIuZAye2VSH3hJR0cAY/nvyp+nPJoBKMD7u+u3U1hfB
   w==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="316748844"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 15:38:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMprMn0iiuPIEELiBDV9zhJX5NQF4cFRXD7re0d8p5KkZtuAJPL/bpfMhQTjz2HFnrODpJC8Oe1egCWakS9yUecKtxtN0CxeExFDvCyReuvhjnFWeEO8yiPPpKl3eiuzbuCfYUJecWyVxRW5lahDfGTw2Kq8E5YYZ/eNwJ1mIMmBxog25QDTOF1YGZwLFxKS6MxcyM39Fnl/t314meqqyQCiiglDWoZricGvtmreW9kDHRBoCOJ0Cap36pMRwopJfV9D29WEc3xg7yy2jBQo2uc3MZ6LTwbSwEuhd2XhFCwPqrwD0Vb/jGJ8q+lCVD18ZteC6DW0tHY7+BP5vgtUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=auTHGlK3i+y2jnhWE6w1nvUtzUWEYEAx9hSfCHyQI5lfXAZ6s7BCuoZyCm69x5MxuoP7MgixH1ngVk2LBruDLlhCwAkjY03Bq0gE0WiCHBLhtDRXHJ/eX5iPPAzXpC9ppVb19m5C7JjeVXr7z8cnjQ6yjjlvwgda5KqzWoq6xQdjQVf3nP9pbzk8Ey/M05Jya2bXlLmsX41WKcdGbxxJYNyMntibw8jgVZ4OgkXp3xVtFAdSV8bHIGZzzpRfba1y5+lpa/l0PnVV4EjlUC4cyrkp0bPOQ/LPXYQg2Dn/TyFWIztVu0LWLwaZwg+2tZjP1ebsztxyhpeVG5/JA2IDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rk/DcML2pDxAQrPk1BhB76AImdyiZvaItZPCu/IVgmMP3wmm7hRkHLFljkNyKsFKGllhiUGnEABI5hvqxx3YM8FZqLT6kn1Gm0aPPT5vYJWOYWwx1OOfPce9fyWdYqUIWvi7J+eroh3aS8Hm6GgWqiuSmVoosQ0L3W69P4iKZ8o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 07:38:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:38:18 +0000
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
Subject: Re: [PATCH v6 8/8] scsi: libsas: use sas_phy_match_port_addr()
 instead of open coded
Thread-Topic: [PATCH v6 8/8] scsi: libsas: use sas_phy_match_port_addr()
 instead of open coded
Thread-Index: AQHY0wUp7ssBYson+0294s4P15nK0Q==
Date:   Wed, 28 Sep 2022 07:38:18 +0000
Message-ID: <PH0PR04MB741626D8DCBBDC09FF0D9A7B9B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220928070130.3657183-1-yanaijie@huawei.com>
 <20220928070130.3657183-9-yanaijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6726:EE_
x-ms-office365-filtering-correlation-id: ac0da841-827a-4107-3e8f-08daa124693a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yj4XcpLdCTDRYsC3uwkK78wKqViSPb4TPaI4SKnZ7kS8GC7gscuLbRzXgndS4iGUYI6IjW/DOUrS/R9Xf2R3xZVkddq/qdpP5y5iJE3uvKq7Adcp95MnW2oKsWDNaEdgX2XowZSAUOBIgkmBtdmVj534GslLetFdlK4k/7lSIdk3lKnJkRmElOXdryb4ssg1lM06M2UTi3WtUTjEOmFujdQe9SO5L1nOQ291U80CBcYqBopP68FyVXbrWRuefwR9sRnwhKsd2YtQEw9wp7fBRCdSG5GPyjtPD0DAwdHPNh0ATSh7BmziiqBm9fSGigW3/uko+eo+M0HzSmG4oLVxLpL2XltjK3Hs6BblJ8lGCCEcdjqt2tCsHbnmxgXis5oYYemWyMeULLx/9ptmvZyksRKap9a7/vmCRt8rEajLjfJcGWOB6WXXfL4mPqyP7rVSaaKC4grbn174e3hru9cfPeHkZleDcX2Hhh7AGToX9BGWJ+KSYL7doAGXLOEi/XqX3FSQVsvzmHPOd3zQ/wNcXYGO80su/2HFzLZnzOV3ccDdtVsQSjeORQTiqYM+2YN5vBX8LaRVoIO4/zhA5HSSnmupo9O58NaoI+XtuukQTCpavfgEe3bpQfECH1NtyMBnI3bWE2xsuoNbZHS+hnOVoOvBTFhL+yUI0Ok8KNp4+mU9JMnvtDV/VE3Y3p7mU/X4JnTIZEgDnLrEkG6G+DqWkyepAZlpl2DJW2tqVItpUuHO4MXAM4rfJvkiNpzqMxpfog76Mi7GFlL0p0TpL15NFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(5660300002)(9686003)(6506007)(52536014)(7696005)(19618925003)(8936002)(33656002)(71200400001)(41300700001)(558084003)(38100700002)(82960400001)(186003)(2906002)(4270600006)(38070700005)(122000001)(7416002)(86362001)(55016003)(54906003)(316002)(4326008)(91956017)(64756008)(76116006)(66946007)(478600001)(66446008)(66476007)(66556008)(110136005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FQeRfSMMBXIKHEGRDBvwp2jgRGgK9yzh7FW4yiXHMgzl+vDQOZDZYe5xrTfy?=
 =?us-ascii?Q?6uI22eCBG0G8urgzxzHfUqE7vl50ypJl8CrTwhDhXU7h7UExwZLCOOEWexDT?=
 =?us-ascii?Q?gNCf2ELT7U5kEfmrAnF25Umz7KuOFOS9HNzmivWpAy/aP3gSTorTnU6j/Lyk?=
 =?us-ascii?Q?ak4n6ancatlcI2T2Z5MxzTYFjVb4UX85hGJSsaw9q3r+XRYTTrvfeJPShI0D?=
 =?us-ascii?Q?JnFZlTueb+yXPl0AMmQH5hl4lUsRiAT1bAdfjPscJXTut+p+sAl49lb7vmou?=
 =?us-ascii?Q?LyTbWsadFmBYQPFYNsyrqS00rdITug+6bGmk9CKlX79zKSxbgJ+hSl0URKO6?=
 =?us-ascii?Q?6HZ2B/gGxzaqLBWukz2Rw6XyOjdwSyTOlD2zA2zd8yY5TsW2TZWK4t/5ZH2A?=
 =?us-ascii?Q?zR7imjGjX02QUVhVG5ECgw3MdTJr27aOfxOPZ3TPJfLqfoMiF6tNTlpBMR1v?=
 =?us-ascii?Q?i7ALvU2QXWuk2YxSCjs78tu55E/f7vgjgDNVFzUG5tFPqP9OVKSZsjg3inLQ?=
 =?us-ascii?Q?j70J6wLWcVKrcchMG5FBsCX1rstEJq5OsnHn5kq0aCaTYwQZHkOwrlMDuL33?=
 =?us-ascii?Q?xOqhDx5ZC+rJObs3akXD+iIfCuaZF3J4tFleBVnWiEFrnCm4OZCRVR6Rt+/g?=
 =?us-ascii?Q?gxSu5c6JYIrwwY/7INuau0THbO0g8ZYsudeZFxCwJLuaFHRlWl+0SxAkby6L?=
 =?us-ascii?Q?tfUURo79ZjKjYEkf05GSo6hAOTFeLtKR3KEy8xGWFXdYri6nws8sG6vZaDwh?=
 =?us-ascii?Q?PiXoYSbqa+VaQGr9+HmozXYJirzF34bXokYFcXfkCjr8xfqvAJoXvnkVL4uD?=
 =?us-ascii?Q?fKcOR7ZTgvLMK8IKI+3pnF+PCeeHuvukIv5/7lrkfn7akdxEtbOMRlEmvr/j?=
 =?us-ascii?Q?+tvKQ8ClMKF43+YjpJBK6VPO/GOebEzv4SUb0h/AmBrbWjHoTf8L0yVYmwA9?=
 =?us-ascii?Q?GTPG1AlvJkD3QyRhu22qd73mZebct91P9MOe9kt4D6iDsbY6hqtcTWafTRM0?=
 =?us-ascii?Q?aoUAVeuGTiqlLzlEDaOxLzXkbzvdMV4uQmy1htWw8Bs8rTY6BoqCMmaD2Bpj?=
 =?us-ascii?Q?lUStcXR2A99F4aWREsRJF9uYgpiunYOf5MMA0UfzsLg12GCMDihhOeX2NobB?=
 =?us-ascii?Q?dsI/lSv05ucv2NLJ8wzlT3qEVUSzh7ybuvb9a5x3+nq17E2cOJ26FMqvNRX5?=
 =?us-ascii?Q?ZqTbitImVTfohjSIx+Kx96xWPQKOJBXGyxCcBpTRPIHdFglUR2xwE0A3EiMo?=
 =?us-ascii?Q?soN8W2gt5Hx119GCJdOrHFP9mfe+CVy2KcwI90Qdm7TyF4y4EY6F5A1fNGop?=
 =?us-ascii?Q?oDt7/jjUw40xIR8r0icO0HrYppCPfbTq1s0Ce9zLcxp15h8i1aHifn5vFSRa?=
 =?us-ascii?Q?ITlWQKuxJWtUuIzbYLa+oRq8m17Aaw5yeHRPOXMlYAKl4TI9frd5IOMtOj5Z?=
 =?us-ascii?Q?8P2O27sq3YHhUftRLCOcwFwVXRvQTWA/SxnmTnF1+K6LfviTAOj1WpPXfcDZ?=
 =?us-ascii?Q?j1ZyUhAGLWgzr1/oGX+SGerePe2FX7neHx2NTCiKZYz8YN1fSAHu+EPlIRSE?=
 =?us-ascii?Q?g1JHBoltOk3S9wK8cTYzBnRWi0zvhllnV3wr8SrsXZy/2jKU05DsTkVctub6?=
 =?us-ascii?Q?fs8UNqu5W4nqD5eaR8WTKT9EPtoksDCYW4/V9/cvVZsc2qI9oLKFY4C3C0kh?=
 =?us-ascii?Q?VGzxmO6sQRMT1RRBibFP9Adw91Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0da841-827a-4107-3e8f-08daa124693a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:38:18.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL4YfVDUG3m8NhVBwyOBbqFUIx2itMxgSrx30UYfDbXH0FRnqtDpWS+WWP7iPMF9KMcK0cawYKs05dxW3KXgchbpDHl2hJVqeX2MhFM0f1g=
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
