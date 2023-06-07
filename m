Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052272575D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjFGIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjFGIUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:20:19 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD17184;
        Wed,  7 Jun 2023 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686126017;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=o9a6W6IRcG9UxBfAKeTK53ItQxdXPk8auChJrgLAX5o=;
  b=QuwXi/GjLMJmZz8+EOgkqZJQ7ZRhposXHfStBNw98Bn3iTwrx6x04ccu
   Ylafidnq0QQtBgoZXR8X16euGaKJX8jju8s5tRuU2DB88TQhK0eFhvUb4
   z8TosDMkgulmTOyozEOlxmybHonXdKANee/b3SfPjTtohTz1jiUr2x1Vz
   A=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 114385224
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:hv9wvqrZruozFl7eaZjqBXfnoBJeBmJaZRIvgKrLsJaIsI4StFCzt
 garIBmPbPiJYGf3fYx/Pti/p0xS7JWDy4BkGgFvqythHyoR+JuZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GtwUmAWP6gR5weAzyZNVfrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAAwDa0yqu+G7+u6ES85opu48KszpZYxK7xmMzRmBZRonabbqZvyToPV+jHI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3jeiraYSEEjCJbZw9ckKwv
 GXJ8n6/GhgHHNee1SCE4jSngeqncSbTAdtOT+3lrKQ26LGV7i8MARMbVmWFm/+Wk36TW+thK
 U4K0RN7+MDe82TuFLERRSaQrHOBvzYdXcRRCOww7AyRyqvS7B2dD2JCRTlEAPQvpMUxSBQp2
 0WPktevCT8HmLSaSlqH+7uUpC/0Mi8QRUcZYy4YXwYfy9ruuoc+ilTIVNkLOKKwy9H4Bzz06
 yqHoCg3m/MYistj/6Cy51XOmT+vjpnPUA8u5w/TU36l7wV2f4qsbcqj7l2zxfJBKpuJC1OFu
 3MHs9aR4fpIDpyXkiGJBuIXE9mB4/eDLS2ZglN1GZQl3yqi9mTlfo1K5jx6YkBzPa4saTLvJ
 UPepw5VzJtSJ2exK796ZZqrDMYnxrSmEs7qPs04dfJLa5l1MQWBrCdnYBfJ23i3yRZ916YiJ
 Z2cbMCgS24ADrhqxya3QOFb1qI3wic5xiXYQpWTIwmb7IdyrUW9Ed8tWGZipMhihE9YiG05K
 +piCvY=
IronPort-HdrOrdr: A9a23:WsiKNq7f0Egz0g+ZOQPXwPfXdLJyesId70hD6qm+c20tTiX4rb
 HXoB1/73XJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIHZIObuEYzmIXsS852mSF+hobr+VvOZrHudvj
X-Talos-CUID: =?us-ascii?q?9a23=3AT63euWr6OM6poj2yUDP1yDHmUfwrdyH08HTdGRO?=
 =?us-ascii?q?HCEFtaJeKT1qSoawxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AelLQ6g5f59TI35LNrYgfmGVZxowr/K2gBUMzr68?=
 =?us-ascii?q?AlNC0GCxJBTWfkh+OF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,223,1681185600"; 
   d="scan'208";a="114385224"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2023 04:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeFQp/wQ2cZmyjfWMKDOXP0csNQ3uF2ZDxXdgdgOpQqjc8RiLNK+lACAvD0cO1aDVPzXoJn2+PDTpQEMa2dp5BWQIzNQPR1HnTZMNoTP4XKw4hWiA5yzsLOrN4gNnt3xy68oXVLHD3rYPMlfCXOt3Uc9stDjf8PCY8DXK0Npa843I8WN4xIeQj/knHAiBjAsLQnlByW38wfe5gnYLSjd2vWreImbGG4l14IV9pvTpBpZ8T34UEnpvGbAITx4psH1MvWxBtJY9Tvvz4bh/iRbEGxTP4MV2ijIYe426/dE7PBgb/yTAaUpe5o0nxWPFkHO8lgHZ3p3oe61Y7up+/kQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yznqWHdJgNxhKmCmJ6V5rM3xWpehs3izcIMgPp7Rcec=;
 b=GCCEL/y1lhNGMT2djey6VWmZP8Uboa/lp4VZBLb2+eNpSCDgbtc/oLFs/Y+mKErd72YykxaGlU6fMm50GBBtoq04ARaP1ZgfMBvkatqfHLnq+ncDnB3d06cYhxPT7i/JKvIl1GAfeVGNDHBo12xS9PUXxnq6Cm6f+ikAcvStLnoS+1CUbukScvMW9PPNTWnvyTuwFP030HtAMgiG9RB5D7pBplSzSU8E9fvFBZeHQ97BZaeYvmHMvPKqGN2XNBlt7P9fkitz4LVwj0gnadBToLPaLReZ7bfOvPGTzRQ+3vXc9yfSA1KMLHr3mHcBqfebyXtgOuIE+Am7QGLaleW/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yznqWHdJgNxhKmCmJ6V5rM3xWpehs3izcIMgPp7Rcec=;
 b=g5jYDBW+acCxFoIVloYM3SVZjEybnnDMVqH1TMBzhr4sAKa4M/ew800lyW/u+if8xia05Ivku/JPg6z1a1ESQP+S2hMDxfmI9c4FrnWxrWgjl8lW01Ka+dC4kr7+Y2lQ3LlghYXeWCnym7gdJr08xuKBaGYufJKxnxhzCg+zbfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by BLAPR03MB5377.namprd03.prod.outlook.com (2603:10b6:208:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:20:14 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::192:6bdf:b105:64dd%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 08:20:13 +0000
Date:   Wed, 7 Jun 2023 10:20:08 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZH9mZGbM32CDmKGF@itl-email>
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|BLAPR03MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e28df12-13f1-4979-ab8f-08db67300481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P8A9dXt53vvMtoJgUcoEVWck6EIwSHohrdPT5QHwZAejjGecYHPtowKl7ZBVfvA6pg1ddK/dkNJzxr0wmC4nnWg9q+a9LFDTBFQJ+Z8H4Ke+va8fkkU7RCZpNwl44/MPCaZJTH7/X7DB2J2AFdRA9MPOPo8BsrZdkfgCmhBsIC1EU4O7s5tRVrvl311JamRJPvTpA5PgMrYHlh4mcRj6MsmX7FJtl6fLFQUseJ/uL+BBQvWPmhMHGxuJ/8UksaKraCnlpIy3tRjW7TGD7Jb9lmVg3jFjv2JHabdLKQvx5ufVvK0bVOPnK9Nx4goYXAYcgFDgdqRfAkVmcHo7nibmJt7y1AohIUwDnqsqqU5bQbco4GpPdNVHao1PdU+trtdo51XMCfig1m0PLPeIfNQBjKIu3I56pXjLchSF0B5+fJ1gvhaxsNdq8caPlXmZ9eRGntz02wLSe7VyRzSWHovq+EyOvvM0cY+ZTUVOWUbUb7U+shpBs+fc3tkrtEfLd6TbSDWnCwRboC1EkdQnYE/uhMfwgwxi/wP8aKdgjE0MLU44deHtF32eGlY+1vxA7sx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(86362001)(83380400001)(478600001)(54906003)(82960400001)(6666004)(5660300002)(8936002)(8676002)(316002)(66946007)(66476007)(66556008)(4326008)(38100700002)(6916009)(41300700001)(6486002)(2906002)(85182001)(6506007)(6512007)(26005)(9686003)(33716001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjNlWC9kNk9GR1RRczhNUzYzcWVaUUFOVWVNcnYwb2hmNVMvdGdGVVQyZ3FE?=
 =?utf-8?B?amcwLzdnd3FsMmZ2WlpRT2hZNG9Xb1A1ZUpSbVgyTjdjZTY0em01TkhPRzFL?=
 =?utf-8?B?SzViVmFCWUlpdUMxdjU3c0d2YkRRbTZhUHNvNDI0RWp2ZkFvZDJBVXN1bmxZ?=
 =?utf-8?B?ejNVbHdDUDcwLzd4Y2F3YUJnaDA4QVNoc1pYbGcraHN2cW15enNVMGJuSjN5?=
 =?utf-8?B?RkRHa3pXMm42UDRnVHR2b2xzYTM4OGlpOFpkcy9wYjFQNHFkZnNJRDZXMnBh?=
 =?utf-8?B?Zk95RVR0UCtrVVBZdWh6T3BQODhBcCtubWxrYy9QaStxUy9lUE9nRk9GVTF5?=
 =?utf-8?B?OVRJRG1tZU9vTFJpWHBsb01xRTVMeVNRYmJ2eVg1UDVXNjA1SjYvQkJVbnJw?=
 =?utf-8?B?UEJkTzNPa0dKc015UUZZbDl3WmxlYndXRVhJZ080OWJxc0ZXSjNHMFFlQXJp?=
 =?utf-8?B?RXZ6RWZHczlHVmRhNW1GVnBsRFowSDBNeTlHdzdvUFRKblIyRkhoUmhSYm92?=
 =?utf-8?B?cU1WL0Y4VUFYdVlvWUhvbHd4aTBnN09UdEJDTkd3TnNTSXliU1RiQjhCRC9v?=
 =?utf-8?B?QWoyU01kdHg1b0FBT000eU1RaUpHSEpreUhZOUZMTnNsRG8zUjJCOGhWN1k5?=
 =?utf-8?B?RzVyTmJyanlYdllnSWJyNGE2Rno5N1N3eHFoWCtMd0pManI4dCtMdDd4cXFh?=
 =?utf-8?B?WFB4RFNhQkNkcm40RFVEdjJmdExMU2IyaGxXMm9tQWExbXgvZnBCU3RGQWN3?=
 =?utf-8?B?MkN2SXpRTlJYMGNxNi9CTmMxTWNsTVFSYXgvZDJIVzNKa2p0Y1hHd2lJMVFP?=
 =?utf-8?B?ZVY0TUpHSTA0TFFQZDEvSVN3N2NIZ1NQcFhlTXJrMXJKRWE2M1JXU0JhWmht?=
 =?utf-8?B?WkJ5dmkvcXVaRGpuNVlEUWVQa3hNbWNSR0g2ZmIwR2M3SWluWWRKZ2FjMWMy?=
 =?utf-8?B?SkRTektrd3RBVlpPNjcxRWg3YStNZGdNT1NjcWNSYytnZkN3bzRyUzlxejI2?=
 =?utf-8?B?VUgvdnJLeCtZNlhWVjFjTFhYZERwTFlpbW1OMVpTTzhwUkNUa2l6ejlQV2ps?=
 =?utf-8?B?OGg1WFNJOEIzSm5XV2tEc2t1UFVxcVBiQms2V0RuRTAwRFg5Z3NPalR5Ykho?=
 =?utf-8?B?RlE1K1psT082cEFESDQ2RWxaQUN6OEJCUkJDN3pJSDZhTDZoejVjUS9HcDBp?=
 =?utf-8?B?S1FXK09OQURYUlEvcVU2M3VGQWJKaEw5Q2h1L3pSQXducWRNbHFLMnExRUly?=
 =?utf-8?B?SWlyc1cydkI1OWlEYUxROVRweWxtQmlsbVZHS2xyb0R4MFZaQnNIbm0wVTVx?=
 =?utf-8?B?RzArK0VlK1d5djE0b3ZpQTRPUU5OaEFpODFGVFNva3RqMzVJUG1hQUMvWC8v?=
 =?utf-8?B?Tm04Yng4c1dRQ2RBOUZuYVNCaFVld2hPQWhvNkRNZGFuVjBvSW5kU1FmYk1E?=
 =?utf-8?B?c0M3Yk9pYzlvT2Z1ZlJzR244NThTOHBNTFluVHB4SjM1N0hsMkhCcWorM2Fm?=
 =?utf-8?B?Q1F0SkZ2VGoyeDdvNkpyR3RqSlFWYnFsOXVaZHU1VFRwdlN3endsU21kTlo3?=
 =?utf-8?B?SmNhNmg0QkN6b1hHd0QweU1EcWpWWXlRbzVYSk1ITEN2bE02bGl6Y2ZibFdk?=
 =?utf-8?B?ZG8zREZLaURpN0tzNFQvZnJGYkxSaDRkeGFGQmJCTWhKOU1DdEdHejJIUU4r?=
 =?utf-8?B?N1Y3bmw4Y3g2NTNVR3JDTXFyM3lwSC9hcU03cmtXOGttWkFBQ1Y2N3psWjdF?=
 =?utf-8?B?NkplTytTc0xjRFJpREY4RHQvWk5lZkc2b1dEWVk1Y0NqKzN1ZGpsTnVUOFcr?=
 =?utf-8?B?Z1BFNzBKUHpvMUVlNjg4Zm9BelZjeElYMCtBdHIvdy9UYTRoRlRtTnNJRW94?=
 =?utf-8?B?bENTZTF4UmVRZktGNjhScldYQXlnS2tZTmRJbFZYTkx3ektvL2w4cjFZd0pO?=
 =?utf-8?B?SEdqVDJnckh5TVRwa2paUUxCV28yTnlFOWJJZTVaYkErMS8wVE9yemJtVVBw?=
 =?utf-8?B?VEZ2dExtMGpzc0Zzd2pLbmV2b1loUkF6UWQ5OFVXUkVMMGlidHh5ZUQ5ZGpM?=
 =?utf-8?B?elUyNHl1SWhFdWdXbGpIdGkwNjVPVW94TjhYaDhjUW4xUmx4eUY2WGd3STdo?=
 =?utf-8?B?OVl4NkNBenhWOEd3OWR5WW5KUVJvaFpNa0lMa05oS2xlb3Q3aFYrWFBUUHFE?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RExkQjdNbEtaQURNK0Y1ZlF0b1B1M0xwWTJoV2piZFJ4K3NWaTFPTUF3Z0xt?=
 =?utf-8?B?WVNvVHJiendHdm5DV3VKOGtUaWZlZkVScS9xbXY0TGQyb1ltZmtPbC80RzR3?=
 =?utf-8?B?Wm1yZVh5M3RkTWpsRGp3ekhGVUp6RzFub0NYUDl3alhoZEpOUCtCUGZMZXFS?=
 =?utf-8?B?SWJSS1Y4bG45VElVNWpnVWxtYVRHdlBxYUV1eGNueHNDYk54RDZlQmJ6Q1Rx?=
 =?utf-8?B?cmVybWZaQjRjcG9LMjc2ZGIzM2RVTjVDU0RuYlFlbWxXUnhpcnc1L0VQazU2?=
 =?utf-8?B?U3IyN3lyMnJYQ0pHQWRVeitibUFHOVJva3JRWXN5eFpvc0pQc2FJN09xL2xN?=
 =?utf-8?B?dnZZRVo2TFh6aGxZWFo2eERpeW5KSXZxTDJWTG85Mjl6a09mT1JaVStJbzFI?=
 =?utf-8?B?RjE5Uno3dU54b3ZqcVZpRzZMTitwOUgrZ294YzEwQTNDVG1pTXcxQVFmTHRU?=
 =?utf-8?B?MTBvNjYwZ2RoN2t6UEd4UDJRZkNWaDdNSkdncWVyVzAzM3AvaHZzRERPZ3Ev?=
 =?utf-8?B?aGJQdHZmeFlObDlmbDBZeUNhaDNSMUt4MXNDYW0yMmxGaE1uTUN3R2FNajRD?=
 =?utf-8?B?aFdRRFVqNEVpcVJXbmZBL3BNYXQ5bzUxaDA2ajMyYzdCcDJFOXlWRkt3dm9V?=
 =?utf-8?B?bzVsYkZuS0lUUGxQd0Q4djM2SzFBNW03Rm50alpBeDlGU2Z1ejFmU1ZESHly?=
 =?utf-8?B?M2FrVmJnZzM3L1VlcFUvRlN4TElXbTAvUlArdURNck8xZS80ZCtCa3VTbXho?=
 =?utf-8?B?REZQRVVpRENhQTg0b1U0VDVyd2ZDcFA0MHpEYXU4ZWt5NUUzN1JPdHZlZ0FN?=
 =?utf-8?B?SVdWckgzS1Y2OE5MSitOUHpxdUhiVDkvMlVja1JXTU14ajBCTmpBWDhPNGtp?=
 =?utf-8?B?a1AzeS9hS2Jtb0hjd0ExakkrbXhrQ0lYVHFBZzRlNnNhM3NrcWlneU5CeHV2?=
 =?utf-8?B?bm9CcnF2aFVKcmFMVU8yYVdva0VCMm9mbGx3V1VBSGYyK3l5VVVpelIrWDE5?=
 =?utf-8?B?SEF2TDgwdlZETXdGR29Vd1BsZXBmeTZYNnFnZFlSYmFaU2xhekdpSS9qWWEv?=
 =?utf-8?B?WDhDWC8zTXE5cXc2WGloY1lLdTAyTWNuQ1EwZ2I0a05MMU9kRVRBOFE2OUoz?=
 =?utf-8?B?TnB1MEZreGUvak81eGM1OUJ1RDhHZm9oSjg5U3pycEp6anBxTEQrNGZVbXFW?=
 =?utf-8?B?Rmh6Z0h0RkpadkpFcFhmK1Q3c0VIYXQ5VDMzVWZLSHNpNzRXY20vTTlLRWdm?=
 =?utf-8?B?T3ZZbDVmUklBQkhwWGQ2emNIdEFOMjQ5YnZxMjF1UTRENzNxQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e28df12-13f1-4979-ab8f-08db67300481
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:20:13.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXjwqB5lyM38IYm0wuzJwV+Q5apU8EH/8zzGlz7twajZP/HMGK5kEwmhtlrnzLo8pygvcxeAS9clLCR4/vd56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5377
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:01:20PM -0400, Demi Marie Obenour wrote:
> On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monné wrote:
> > On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour wrote:
> > > This allows specifying a disk sequence number in XenStore.  If it does
> > > not match the disk sequence number of the underlying device, the device
> > > will not be exported and a warning will be logged.  Userspace can use
> > > this to eliminate race conditions due to major/minor number reuse.
> > > Old kernels do not support the new syntax, but a later patch will allow
> > > userspace to discover that the new syntax is supported.
> > > 
> > > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > > ---
> > >  drivers/block/xen-blkback/xenbus.c | 112 +++++++++++++++++++++++------
> > >  1 file changed, 89 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > > index 4807af1d58059394d7a992335dabaf2bc3901721..9c3eb148fbd802c74e626c3d7bcd69dcb09bd921 100644
> > > --- a/drivers/block/xen-blkback/xenbus.c
> > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > @@ -24,6 +24,7 @@ struct backend_info {
> > >  	struct xenbus_watch	backend_watch;
> > >  	unsigned		major;
> > >  	unsigned		minor;
> > > +	unsigned long long	diskseq;
> > 
> > Since diskseq is declared as u64 in gendisk, better use the same type
> > here too?
> 
> simple_strtoull() returns an unsigned long long, and C permits unsigned
> long long to be larger than 64 bits.

Right, but the type of gendisk is u64.  It's fine if you want to store
the result of simple_strtoull() into an unsigned long long and do
whatever checks to assert it matches the format expected by gendisk,
but ultimately the field type would better use u64 for consistency IMO.

> > > @@ -725,10 +749,46 @@ static void backend_changed(struct xenbus_watch *watch,
> > >  		return;
> > >  	}
> > >  
> > > -	if (be->major | be->minor) {
> > > -		if (be->major != major || be->minor != minor)
> > > -			pr_warn("changing physical device (from %x:%x to %x:%x) not supported.\n",
> > > -				be->major, be->minor, major, minor);
> > > +	diskseq_str = xenbus_read(XBT_NIL, dev->nodename, "diskseq", &diskseq_len);
> > > +	if (IS_ERR(diskseq_str)) {
> > > +		int err = PTR_ERR(diskseq_str);
> > > +		diskseq_str = NULL;
> > > +
> > > +		/*
> > > +		 * If this does not exist, it means legacy userspace that does not
> > > +		 * support diskseq.
> > > +		 */
> > > +		if (unlikely(!XENBUS_EXIST_ERR(err))) {
> > > +			xenbus_dev_fatal(dev, err, "reading diskseq");
> > > +			return;
> > > +		}
> > > +		diskseq = 0;
> > > +	} else if (diskseq_len <= 0) {
> > > +		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
> > > +		goto fail;
> > > +	} else if (diskseq_len > 16) {
> > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but limit is 16",
> > > +				 diskseq_len);
> > > +		goto fail;
> > > +	} else if (diskseq_str[0] == '0') {
> > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with '0'");
> > > +		goto fail;
> > > +	} else {
> > > +		char *diskseq_end;
> > > +		diskseq = simple_strtoull(diskseq_str, &diskseq_end, 16);
> > > +		if (diskseq_end != diskseq_str + diskseq_len) {
> > > +			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
> > > +			goto fail;
> > > +		}
> > > +		kfree(diskseq_str);
> > > +		diskseq_str = NULL;
> > > +	}
> > 
> > Won't it be simpler to use xenbus_scanf() with %llx formatter?
> 
> xenbus_scanf() doesn’t check for overflow and accepts lots of junk it
> really should not.  Should this be fixed in xenbus_scanf()?

That would be my preference, so that you can use it here instead of
kind of open-coding it.

> > Also, we might want to fetch "physical-device" and "diskseq" inside
> > the same xenstore transaction.
> 
> Should the rest of the xenstore reads be included in the same
> transaction?

I guess it would make the code simpler to indeed fetch everything
inside the same transaction.

> > Also, you tie this logic to the "physical-device" watch, which
> > strictly implies that the "diskseq" node must be written to xenstore
> > before the "physical-device" node.  This seems fragile, but I don't
> > see much better optiono since the "diskseq" is optional.
> 
> What about including the diskseq in the "physical-device" node?  Perhaps
> use diskseq@major:minor syntax?

Hm, how would you know whether the blkback instance in the kernel
supports the diskseq syntax in physical-device?

Can you fetch a disk using a diskseq identifier?

Why I understand that this is an extra safety check in order to assert
blkback is opening the intended device, is this attempting to fix some
existing issue?

I'm not sure I see how the major:minor numbers would point to a
different device than the one specified by the toolstack unless the
admin explicitly messes with the devices before blkback has got time
to open them.  But then the admin can already do pretty much
everything it wants with the system.

Thanks, Roger.
