Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A816D8F08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjDFGEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:04:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA57687;
        Wed,  5 Apr 2023 23:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9zpBw0umtgmW6QC87efP2JTTC27RPJfNewZir+kFS2RVCAiBUIpYJ8yGnjCnlEAuA18GJMtrTnbD+QrmZ2jqnOzimoC3o0RP4VhUM+2lDYwp/DU55KOnzuRZp7rKPCYxmSTudmjg+WbD6/KK/MhpT1VSM1Yq0KyvmmICULhJOzKxlw5m5ZzEJi50SswfxDab9zsIHPc6AqfiDqN8hJqvoLBas2ppdF/PM9NehmCHENZaSnGjGKUh9mKLuC3Eg6Kf7kXywFoTWHu7jAl0SYbIJ0xjWSLS8rriMpOvY8NaHamWb6FL/mtgFIpZcFdj6D+1z9sHQFsSObEkt+VHFLJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOJYQG1A35wqCjzyxApGJ2GKJXcuAFyRC0rwJsVGvI4=;
 b=iJb43RDMt8NvyKmP42433MQCd8xwnSaW/fr04aWebcThFUewiyTdmlyVgdS+u2ptEtxDXzt/dHWd5q7P0FA72VflC0FtN+pyuTmrKGjCek3G9Qn3VOqC63Y4vrcHwHJay9PEDNlvFjUmx7Z3tsCjmhUh2FB+gvvkKG5RsmeuIuBvJa69Y6ZMUwjgHdNwejA5eAoOFBYXygwdofiFBcjRsiXka22uK8flSgCUcaXlf+jX8ptzYRoEhm0/u4QMVRR4JoubLlhZ566/jpiuNDZ2/F4x5Hte3RWkItlstTHqOrHV8a9qULZpx5jQMqyr+OqltfGMhZYXpsZDj2nD5gBtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOJYQG1A35wqCjzyxApGJ2GKJXcuAFyRC0rwJsVGvI4=;
 b=fQWwJ68z/jBof7Lj0O23t0QjiWxVJLxxVETfzn1isqoQYl4Hzc2zYqxjcdbJwrNL3SDTrV1ImA4NG2uOIXt1y+Gq4a5E/vfXc1FtFhIOIuDV+uU/kmlqnhQSHgDh8eFPNCrnrYOb6c3jE+XCTwpU5u3hZxz/MzI7+xJuFdr4o1wOFrLMdp4hWQH+VjAog/zvW5jQaB4YG4FA1Nmw0SlkemgzsH4dJhW0AFwg2QT7JWi6shYi7ri1IRM3WrNIKj5fOSU+eTX3DAQ43GLZR+afEaB1JNU2M5rlnH0X0KaHVxV9TTZRBa1XN2vwboQgS7txnlKoOpo9TOwL9wkgBGtgQw==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by PR3PR10MB4013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.28; Thu, 6 Apr
 2023 06:04:42 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 06:04:42 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 9/9] tty: n_gsm: cleanup gsm_control_command and
 gsm_control_reply
Thread-Topic: [PATCH 9/9] tty: n_gsm: cleanup gsm_control_command and
 gsm_control_reply
Thread-Index: AQHZZ58yWFMH6Iw9XkyLIXEwt3HhX68dzBvA
Date:   Thu, 6 Apr 2023 06:04:41 +0000
Message-ID: <AS4PR10MB58953283D47928E265313660E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-9-daniel.starke@siemens.com>
 <345feade-76b0-b8e4-60fc-6ce03df3ebe1@linux.intel.com>
In-Reply-To: <345feade-76b0-b8e4-60fc-6ce03df3ebe1@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T06:04:40Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d1d80218-11c3-43ae-be0e-29973874e8d1;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|PR3PR10MB4013:EE_
x-ms-office365-filtering-correlation-id: 1be59ba5-7a52-4452-c3de-08db3664d02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/1HPeZnZgrGS3BPf0mzI5YhHDEtxZ72Kj1ADBl0Jb3KeWpgBAlo5RIUKw+CfgAI2LXnfH6Ltn+YRjdJdf2P2tIFCONCAqvBs9W5ogyud/AFdCxl9GrjGuvhR7bfY8EMc7DX07eKndQ3OMVv8J2COP9jzr9Gb5kOBm0sxVBqqunXs+vxrmmii2ulvY7NLayiG4kdtx2KbtBSUTZvzu86KCjBlYk/iRtXKyfhjXSL4dkd5Twi9Hm3vBtgyLRRmWDGNfb4GK/B9lVnRBNyX8KDTgCmvm1/ZyaiuIWPiMZufiyJrTctiMII/EKoaDWpMoKBXk3CUeBNRxddwJ2YjZi9IN0Jlc6ocYXZkzNu1YbiAk5FNnE9dzrUalVSv69Fa6pRs2qiRRnxFlyTYYso2zPsTkmIfa80ysVN21cOweyuUAGgiN52jPOgKCDN38rbJ5ccqAhKpEvus/Lgl0x2fvCx76SZPFJPETaE0UWuGKOHb+BGuNSGxhSUUzqKcPZ1m+IAGhWfHYUM56KhHGJ7sKzA/QKtNu4uCvXOLLlzi94sd5DoUoH6pYMQzh5RQ7Ppoyb8atHqwK74RYTgKbC50OqQJk524eK5H9zU8Ddiw9TQ2siQcAGeJinPJcnC4IdEspLL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(55016003)(186003)(4326008)(122000001)(478600001)(66446008)(64756008)(8676002)(76116006)(66476007)(66946007)(66556008)(5660300002)(54906003)(316002)(6916009)(52536014)(8936002)(38100700002)(82960400001)(41300700001)(83380400001)(7696005)(71200400001)(26005)(9686003)(6506007)(86362001)(33656002)(2906002)(558084003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+Awz1ZjrW35rNHD+i2zRshSzNRfssbmBAIRpgUZrZhNdpzoixnZaVTInfq?=
 =?iso-8859-1?Q?Cw3e8OM8KFglzpSameScpdW2g0DbVijE7RBFTNP/BGbGRAKWeO3IV6iMHb?=
 =?iso-8859-1?Q?b69+sMhrWVutWg5kWKp5AZLa1OXRKQLP0Dsd2jaJA50dRKyOTDG2nQdr0R?=
 =?iso-8859-1?Q?71LYO0X72P9QCufV0fMZKOg76fm6h/lNOTC//E+Ou0uRk3lxJJnx0KsCzI?=
 =?iso-8859-1?Q?/pUPZJdh1rUYMNRZmhBbZOPsZMDwR228CTvmKONuyVXigqg2g6+OBf6gjp?=
 =?iso-8859-1?Q?PJxbPJ29xPDn+e56VPblIjqGvTy9jWb07CgX7BZEzF2+A09Y+xEwJhMsGu?=
 =?iso-8859-1?Q?x/79iSDQBVnFnp2KVGd+BmEDXrG13+vYCKzWVx/s/iosH/vLRfhTqGuYGx?=
 =?iso-8859-1?Q?xxYFHl5Sk4OWLipk7M3C+0/I23WrUdhzh/Vh5tsLPAoFeJ1YbuJ9CAtHE+?=
 =?iso-8859-1?Q?enwUm8ctLM3cHDUerFOszNNqsognggfF+6hCJdxu3RI0v/7/wPRxiuyZi0?=
 =?iso-8859-1?Q?KIy34UmJfhagJhk8vRZv2akyEJBp1KJGoA+Mz6Osrj6yzqlO7lfMDcQKn9?=
 =?iso-8859-1?Q?2h1s38zaCSyliJBe/HNlfScaOerVzxryl5W8Sh9ZxG22hM8l1ZDXzfwDcB?=
 =?iso-8859-1?Q?NSYSHWT60GRZH8HNxbMJD2/t8xn7xiDLbzc+mdatyRYNWCKJXRep5MJLhi?=
 =?iso-8859-1?Q?ZnwUP25WoRdTyDHn98D+i8wZDnGT2tP/YF9Urvh3/IMvadyMGWmlo1d4H3?=
 =?iso-8859-1?Q?E6yONOjG8MrWcalx+7yjOXDl5M59aDwNSiY0/7LkRcCM49f/ovG+o7pSc1?=
 =?iso-8859-1?Q?xX9/gcpUeg6uyGyH2HwTE6tqnLOSVuJ1eYWi+LUtInTLp525WZy2siyNAy?=
 =?iso-8859-1?Q?yQ5JUtxdoEPy637OUWrKeVrJVvThCEtWYuBP1k4hWUWAcMZWwMOPXrZbYw?=
 =?iso-8859-1?Q?ATiOLTUN7HFk2cUHjdaMAcNZ6GG6Q6D2oCGz2kfF9LD/9s1XNIQRkAZ1Kl?=
 =?iso-8859-1?Q?MNejAzuJ6rJSod2rLcA41TPx+UY7lfzWxd2GS4/ThCTYwMSSyYPIaqkRxV?=
 =?iso-8859-1?Q?djA1/5AIRzzsE07aYBdxBb7+CWHVboMzHn625lJS9iOtrZj+aMhd+w+Yxr?=
 =?iso-8859-1?Q?GYfQw2k8/MW8MgFAZ5NaqxFvZllUC6RQgrnObqlX5yowlPQxPc3NYJ8eup?=
 =?iso-8859-1?Q?P8dJ2aSs8GqmJg6tB2S7L8DdR2Vdn/j74EUuD8Z9C4HGFS2JD0RkyHTg0E?=
 =?iso-8859-1?Q?M0P6lmpnuXQ7eaNgpeB8HuW3GxNbpcuEEXy6MV8noPG92pAE8cLcB5BWJh?=
 =?iso-8859-1?Q?nss070bwwC3exjpMIkN8DOGh1yr1XD1ZKNA7u5IRC4WLYv+buUXHucT3br?=
 =?iso-8859-1?Q?hXN2jDWbWww5G2UjUng5aPa3RmGbGVde6cKOIyppHriJtcAA5PaLmrOqFW?=
 =?iso-8859-1?Q?0dGkIrxw+yYCmAE02c/pyZrCyN76VWnBbekbJyQgQ16GviBQoUTtrHF2C5?=
 =?iso-8859-1?Q?cYwV4IEkMT0RJnrdSlWNMTzhW1RMqtprS0YJvNApaU8TbZKvjJtxBiLngZ?=
 =?iso-8859-1?Q?v6T1YeHZMZMSAy5P9S+3tdNKGfVbhFJcphZ3RCHZXxjP2k4om/ZrKte81s?=
 =?iso-8859-1?Q?6Ae4h3tThgnR0QgycPkPkJpRMLdY5QCk9j?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be59ba5-7a52-4452-c3de-08db3664d02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 06:04:41.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijegV/QOlQ6D0jlZOZo8rJLMbWIEq1OSMyfxDXu6T/Pw+9ABoG2tZy0enQLZysNDBmAxjGoTcOxmOFV7YoTP9OCc0WFKpdJiFel4Be4+cp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4013
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> IMO, this patch should be done before patch 8/9.

I will change the order in the next version of this patch.

Best regards,
Daniel Starke
