Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92D774B340
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjGGOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGOsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:48:55 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E22B1FE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1688741334;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=62/FswiQFDWcghTlfWsBb5f/aPgx3KmTIU08CKLH4wg=;
  b=K1pa1p+bn064S5voWcTRnJlvTMFe6QZKrLfDopyRELWm2/845u5At9Vl
   3AqBWSQAF9PXqmDA8tN/92mJJmdpJcOm5bpYsYiKVJaT8X5YG0kODP8p9
   IQAcqMresSYFOxqfONdZHuP13vaAjqeKgsJQOlYFpzLC+CAOOmD0vNBwS
   0=;
X-IronPort-RemoteIP: 104.47.57.42
X-IronPort-MID: 118064942
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:mvO33KCzbMtJRxVW/2Djw5YqxClBgxIJ4kV8jS/XYbTApDomgTcEm
 mQdCG/XaP6OMGP8KNAlbY6w/UoC78fRm9ZhQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMsspvlDs15K6p4GxA4QRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw9dk0OXkQ8
 fIhCzUpXhqg1+24mvGFRbw57igjBJGD0II3nFhFlWucNtB/BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI+uxruQA/zyQouFTpGMDSddGQA91cg26Tp
 37c/nS/CRYfXDCa4WPcoiry2r6Tx0sXXqo4EbmVzvl03GeR33cVWRwqBEWnr6mm3xvWt9V3b
 hZ8FjAVhao97kuwVfHmQga15nWDu3Y0QMFMGuc37AWMzKv84AuDAGUACDlbZ7QOs8s7Ric2x
 0SJt9zsDD1r9raSTBq1876OqDqoNCs9LGkcZDQFRw8I/9nipo4oihvFCN1kFcadqdn4Gir5x
 TyQmxQvnLUYjcMN1KKT8EjOhnSnoZ2hZhY4+h+RRmu76h5Rf5O+asqj7l2zxeZNKsOVQ0eMu
 FAAmtOC96YeAJeVjiuPTe4RWraz6J6tNDzanE4qHJQ78Tmp02CscJoW4zxkIkptdMEedlfBf
 k7QowpUopBaJnu1ZKtfaoe9Tc8tyMDd+c/NU/nVap9VZMF3fQrfpiV2PxbMhSbqjVQmlrw5N
 dGDa8GwAH0GCKNhij2rW+Ma1rxtzSc7rY/Oea3GI92c+eL2TBaopX0tajNisshRAHu4nTjo
IronPort-HdrOrdr: A9a23:Uj1sPaN9VxVxi8BcTjGjsMiBIKoaSvp037BK7S1MoH1uA6ilfq
 WV9sjzuiWatN98Yh8dcLO7Scy9qBHnhP1ICOAqVN/PYOCBggqVxelZhrcKqAeQeREWmNQ86U
 4aSdkYNDXxZ2IK8foT4mODYqkdKA/sytHXuQ/cpU0dPD2Dc8tbnmFE4p7wKDwNeOFBb6BJba
 a01458iBeLX28YVci/DmltZZm/mzWa/KiWGSLvHnQcmXKzsQ8=
X-Talos-CUID: 9a23:2Jbi/GHMr3cmAH5PqmJoyw0sAp4hfET+yVPgKWzoBmgzC4OaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A5u9mlQ77i3y/DbZICeSro/S0xoxC5qCDMEcTza8?=
 =?us-ascii?q?EotKCZC1MaimBgmSoF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.01,189,1684814400"; 
   d="scan'208";a="118064942"
Received: from mail-sn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2023 10:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Eq2Xk46k/1xZ91oVlblDkNnTIe2edzYsHk8CykfhT2Y1RRF1e189OA1pbxfc+uX6wf7TaZjdgDV91Qk9ty2G4OI92IgWAQnzHzasR8k4DbGeP4mFQBhGZlDlwpJ1ShHuqSSgg+lciVTFuMKVKX9PwgeiAB050ExE3gUCb7FqtdEfFwubZ1QcZabiCX0iy0yBUcIo2t+ihQRz6k1+BQ/jf1P6eGrlHwPP8vfpFBGu+w1W3MQTpIpFB96kmn8iMtKibybAlkLX1GbPEpDK7QGhyMLBJttWMnPhI0UdwMOEH9hjsaSssKR46M74Xxk+0L/U2I+yaU8m+WjKAPUUVqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2tsQNXpWd5IU/s4iz6MwpCQnaYnQ6BMZkEvquP1dN4=;
 b=LiYm5OQcPAlI5IkjEXozl1o2EC4RzrCgVA/0CgcXzoLND/OJpnNSgFF0Ie9PU0PT9W0y4L6HxGJ5dY5GLp+U9vNSbOnkMIxn+UCiwbxz5ykBTxiGR55BjnwFAGI2AfpscyA0l1beokcxwAVusdrSeyN1OJ0PcyMCC7zuMfnaoNo8nR8P2hZehojIopTXxzeY7hfUdTb6ngkybq5hM1Y/MajoNkD4friPckpjTzol+5g4bfwHf+rlBF0PTx1M/n76ygPdxrCxHWkjQz8eztr+C382edLBoslG1FcV2OfDXjMqWeBK9ekpCNA8nzIL0UZTQHxosPmnOoHjUZNbcMonBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2tsQNXpWd5IU/s4iz6MwpCQnaYnQ6BMZkEvquP1dN4=;
 b=vR8VnN407xjTIusekGwFzg5PqUejeFidseasZ/ne6knDXT8y/BfKz9hHt8Sp9NaikQhRb4awHfU64+VI6tBl7bPPPoQUgYEngJgIUcGrVazLuYQ7VlyCPaeO78j7t8QlcF3BV4j/SfWa/n0xQd+Kw4smzgLhsxGobUpNtHiXeqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by SA2PR03MB5689.namprd03.prod.outlook.com (2603:10b6:806:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:48:50 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::95db:33e0:ebe2:13dd%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 14:48:50 +0000
Date:   Fri, 7 Jul 2023 16:48:44 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKglzGG6PeRPPtbT@MacBook-Air-de-Roger.local>
References: <ZKQxZY03x30rjdoF@MacBook-Air-de-Roger.local>
 <CAPD2p-nG8SbNYF6Ob262bP71qXNGmWLZcYTLO-DnnmTQX2VHvw@mail.gmail.com>
 <ZKUqomfCfjrQUt6u@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307051540590.761183@ubuntu-linux-20-04-desktop>
 <ZKZ4fAfbKsVEO_xo@MacBook-Air-de-Roger.local>
 <alpine.DEB.2.22.394.2307061449160.761183@ubuntu-linux-20-04-desktop>
 <05341cac-ac75-a6e5-9c29-3caf83ea99fc@suse.com>
 <ZKff0w2EpzX5r8vK@MacBook-Air-de-Roger.local>
 <74493ba6-48c5-6326-b027-0b6761ef4836@suse.com>
 <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00f2ae75-b3cd-6c6d-c1c5-b2e9d6a974b6@suse.com>
X-ClientProxiedBy: LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::7) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|SA2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3aba4e-7a68-4c17-a248-08db7ef94692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3eYE/187LgpPM0Tka7lze/gWcHGv7xGGqmxzBzx7Tx0yZHoA5FRE7FSLaVIB67y5YR/ir3Gogpx3eeBlUMB30Lj4J7LO2V486/wY7liNdTy/pForcpxmbp20CzqhTeMb/kbi+Jn9LS8KDt6F7+2W1/xXEQw0713jGE9fmwhuShi579N1ec7Vc08gZql5h6zRq9JeVHPzH7VwARF+wubuJMl6w64YwOO+pKa7Q/A9aNUNUhskpFrOroU5XhWaWgREdiYazh96Tug78NQwfj9rqePGboUMrnmB1wWvTmLmKst8PS0+3auKS0fIhtCa6sUVyGupUp2R42qGDa7vs+Tfh9DgixYA6PhKcrIinFfrcjTYKTMn/lS1LEA997WeBRRLJnF+9qrRsRjsI51xtmxinUVV/N2CPjujPC3PDcT6Uq55lCjd1xs2IPF7ow2k9mIMLLfawwA4tVgAzqXrPjfOvisIQaPoE8ZRm1iYO+djuU8VUstztIYFV29K+CZ1TCoLzlz+FUk5DDxaIzKiQww3L782Zi6C1mpZO74YsQNlP6jTOwA35u1WTvDl/mRAgvR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(83380400001)(2906002)(66476007)(66556008)(6916009)(4326008)(6486002)(66946007)(6666004)(316002)(54906003)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(6506007)(9686003)(53546011)(41300700001)(8936002)(38100700002)(82960400001)(85182001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BiamQ4QkRSa05oUWVlblBadmtNNmgyU1FlUE9MOE51Wmt0ZTU3Q3N2T2F4?=
 =?utf-8?B?VUhGa2kyRVJwUm52VlFnbW9QelFtTHozQ2pMcGRmUytKdlNUY21SbGVsTGpu?=
 =?utf-8?B?U2tLeHA5akdWS2xyNTFvS2pzMU9CN0tTcUttQWorbVdqcmg2UE9GSkRnckFj?=
 =?utf-8?B?L3lMc3NTVVRVeHNIcjZZYU1JTTltWTJDMVk4ek1mUzhidGpZMGxUdEp5cUN5?=
 =?utf-8?B?S1pKS1NSTkVzYWszdTBTRUJ4UEZZTDBwZ1NlQmk0bVJhN1ZiSWZ1bWFHNloy?=
 =?utf-8?B?a1YxYy9pME1tYTRuNHZqTUlpOTc2MnFoV0ZpNEpic2xCaVY1MjVITXVPSWxq?=
 =?utf-8?B?MjBpdE5oUTlCVk1GaE5LQVZ5eE1YN1VMeWFud3ZSaUpsMXhNNmF1UlYwaEp5?=
 =?utf-8?B?VE5zWUR1THVnZE1vbU43N2VNWE9sRXYzeG1jUmhjeUZZM1UyYndzem9JeG8v?=
 =?utf-8?B?K0NlQk1WNEgzeVdXT0hBWUdlRGVkY2QxcUhjYXFjLytHZEZkVkM2Rmhia0RK?=
 =?utf-8?B?V2JnSXRZRGNWVldnM3VhRHU0M3crZjVCMkt2NE8zd3E5YXhpdWo3N2hEUXJ6?=
 =?utf-8?B?WmdrNTZJdzk3bTlMRkpiSmFqYUJoTWlHVWtWVy84Ym4vRGcvOTBaeVBKc3Rl?=
 =?utf-8?B?UkZhSVFjQXFvM3RHajJyRUJVd1dCTnhzZm1vRUVwc09OaFNlZG1OamxHNWZD?=
 =?utf-8?B?cldEdmZqcDV5WTE3c1k4RUJQQkVjK1Q1a1dra0RLUitrK05RL3lRM0Rza1po?=
 =?utf-8?B?STV0VFhyZ3BMZmhCRTQwYnBZQlg3dDhub2RFUWhXWEJjR0wrQ25JVWUzNWdh?=
 =?utf-8?B?Z0Yvcm9yNDNnTVdXRURhWTlmd1N2c3VpY2pSSGVEd0N1YktROWRXZy8rWnls?=
 =?utf-8?B?bE56VEI5MFVqVi8zajRVc05abjJVNTgxbmpnbGZYNk5tbEhHODROSnNQVjFP?=
 =?utf-8?B?bG5ZWm1HNTkyQ0JMaU9kblVPNUpMV2xXcS9UY004U3VyaC8rYWJxYURvL1lq?=
 =?utf-8?B?c3dQNVlzc0tiMFJyYkJVam5hb00yUXBZY1ZKL3hGdnBqV0ZOeCtabGNxUmoz?=
 =?utf-8?B?K3NaV3A4S0NBcHdneUNSZmJSVGNiK1FMWnRTWHhNbitFTjMwOGN6dmpUWko2?=
 =?utf-8?B?MlFNNHJWM3lockJ5ZTluWkwzaVZUY2ttVXdMYm5INTFpVCs1TVU0bGpJRW9n?=
 =?utf-8?B?M1RvZStiWFFHK0Q1Y2JWMlYrTjBrK0hKRmc4dm5OZFdNMTZjVGdUL0tkZEFl?=
 =?utf-8?B?NGF6cE1SYW9Na1RrZXRCZjBETElJbVN0QUEzaTB5QUFGWDJTRmp5ODZiQWpU?=
 =?utf-8?B?dWt1U2tyaWVWZHk4NkxVSmdFUWtrY2M0ZFlPTXVGdWh5Tko0bzlueGkrZkFv?=
 =?utf-8?B?cDEyL0ZLMjBHUVNRaGZlUE8yK2JHMlZHVm1nYnc1SWhHQjFEcTduUDVOdFY4?=
 =?utf-8?B?ODdKdUdab3pzU3U4V0J6T21Ib2hEai95bWdVTnBheVkvWno1Rmk0SDV2RDd5?=
 =?utf-8?B?R1BnWnlpZVJIQkhjMjJ2djl2TTQ0OFVGYWE4WUltK0Q2RS91T0xHU1BMUjl0?=
 =?utf-8?B?R0VHaEtkWXpNNDIwRGxaQmJ5N0JoR0ZJaVhNdFdOcTBJN01CMFdCaTZDbCtC?=
 =?utf-8?B?UllZWWxETHlQdlRBbFk1ODZKcUd6MXUwVS9sK2cvbVkxR3JkSVYvYXNicDBo?=
 =?utf-8?B?VmpSd3RMMDFjNSt5WFV3RXFSUW5XSGVOUitQZzlqZjJ5NmZXODF3VjJDL2wx?=
 =?utf-8?B?bmRUWWdTZ0xvMlpyUmx5M3NmdDkxL2NQRlNCMk9lZ3pNV1J4VkNFS2xTNUtx?=
 =?utf-8?B?ZUd5L0wyMnFWSVp6OXFyc20waHVRVCszb083M21qUFZNQmVmZFROdDd5QzZM?=
 =?utf-8?B?YTdUZUxXdmRyVE1LOWgzbWFlVkUyUUtaZUhDWjZ5eHhFZjIvYk01eS9id1BW?=
 =?utf-8?B?WFArMG9XQjY5MnA0bS9SaTZ2THA1T1B3UXlGdDZpSFdtRUgrckJQUHBkYW4r?=
 =?utf-8?B?L0drZWoxTGM5ZWtURDA0STdhZEtYUnk5NHZOL1pLamJCaU1nZ2dVckttaGFi?=
 =?utf-8?B?a1lXM2RDRFE5SnhmNXZHQVFUeHpZbTV4ZHB3MXU4Vm9zL20wOThMRnRuMmtq?=
 =?utf-8?B?cDhJT3hBSGdBTWU0bUdyYUJlVHJkUkplNE45T3k1Q2s4RFpYL1FNUExBa3hC?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aEZXZHp2N1hyQWYvM2FmQ003L3N6WjFGYnBZaWtUekVmVXlYaTM1bTczbm1M?=
 =?utf-8?B?RWVIMHBXTk44WmQvQ0hBcmxMMTFzb3dwK1pVTXlpbUZRd3NVdThmYU9DcU5G?=
 =?utf-8?B?SDhEaDVUSU8za0dKMytWcW9jL09IYXNndEhkMStSZGNYeEZJY0lRdHhsNklS?=
 =?utf-8?B?WnlicmRWODgxc0Q4SFRCVHZxeUErb1hKOHJ6UUZwdC9MUk54aWdvWW0vVUZF?=
 =?utf-8?B?aGFUbWQ4QzdLbk4zd3R5UUdGNHRKZ0dGSzdXVlpkTmlYZFNvR2krWlRmNjF2?=
 =?utf-8?B?T0s1elRacDFrNXJZNVIwT3FYa1o3Y1RXdzByK0dSeDdBYThCYUJ3Y0NiN2JR?=
 =?utf-8?B?OHlSRUVDYzVGVVpyTUdtbm5ZY3hkU2FsdHBCcmRSODdFQzNWbGc5NGNKUk5N?=
 =?utf-8?B?ZnVORzFCZE8zWVluQnNFMldHdHI1UUZ1N0NhY2JtckZac0R3aUZNTUd1UDQ1?=
 =?utf-8?B?M292c1plU0RWamkrTXBNSjhYUmo4M2YvYm02NnVSSVJLM3NRSkJWVzUrNUta?=
 =?utf-8?B?a1ZwYzh5Y05zNkxWbW9uUGMzZVV5YXQrK1pqRUY0b3hJanhha0w5ek9kN3By?=
 =?utf-8?B?WENucTJ2dVdybFRJN3B4S2V4TlRsK3RucTk5SkdIK1VmUDZ3YnJ0WDVFOUtB?=
 =?utf-8?B?LysvV2FNRDVEWmVqN2syRkZjaXQrVFh1YTZWSkVIZVhPWUJVbml3UGF3Q2VH?=
 =?utf-8?B?UjhmVFVUcEtadEswWlliRG5yc2VXVEQ4WmMxYTJoZlNKUkRWR21oamYzYjV4?=
 =?utf-8?B?R3Rqd0RtVGdmaGhhTmlvTk0vMzhJTVY4VnlIaU85a2FVeEdSalhUYnlnTk1C?=
 =?utf-8?B?ODhYeGI2WDZqTTdtVTYxaWdOQXR6ekd6YlZMN3ZRUkJsSWEwR3Z4QXg1VnRj?=
 =?utf-8?B?Q05BcXNIOUFNaUV6eXhEWE0rLzRhK0w3RkVFcjhkMEZwT0VoRjBVTTRUd2RC?=
 =?utf-8?B?R2lpLzdldmtmMjl5VExPdjZYQ0lNRjhUUWtOZ2R2bGxLUHZTTEE0aDRLVytv?=
 =?utf-8?B?dlZDc2VuVVNlN2UzSDBLaW10cm1WSlVjaEx5OHE3R1pBRE0zNVB3aTFYQkZB?=
 =?utf-8?B?VmE2bzRkMXZESDNCMmY3L21lZ2dvcHJUWWFKaXh3MlZkQ2ZodFBNaHBOY0N4?=
 =?utf-8?B?TDNHMDl5eGFGdm93S0lCMkFyMVpobUliWERXSFJYY0c1aThpL0dmbk45REo4?=
 =?utf-8?B?TldFTXFNQ3FLSnBiMWVRaDBFYU9ic1dSd3MvYVhBQTBEZ2QwREZJSHhFS2NI?=
 =?utf-8?B?bkU0ZzBFZkNDNjFjK1grV0hkUGN2MUR3bVlDVUNpdFB6TnhaT2FianJOa0U2?=
 =?utf-8?Q?GPjsi/aNoQeiJY3lHOEx40G5hSR/i3hirU?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3aba4e-7a68-4c17-a248-08db7ef94692
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:48:50.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdfC2w+0to9KS59JSpIo+c+mPQQ2mWneX+Z7aCHt77KdQbbutMsVShlCj45A2MhBuXMvxj7ZbRi4GAmbr0AQfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5689
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:27:59PM +0200, Juergen Gross wrote:
> On 07.07.23 16:10, Juergen Gross wrote:
> > On 07.07.23 11:50, Roger Pau Monné wrote:
> > > On Fri, Jul 07, 2023 at 06:38:48AM +0200, Juergen Gross wrote:
> > > > On 06.07.23 23:49, Stefano Stabellini wrote:
> > > > > On Thu, 6 Jul 2023, Roger Pau Monné wrote:
> > > > > > On Wed, Jul 05, 2023 at 03:41:10PM -0700, Stefano Stabellini wrote:
> > > > > > > On Wed, 5 Jul 2023, Roger Pau Monné wrote:
> > > > > > > > On Tue, Jul 04, 2023 at 08:14:59PM +0300, Oleksandr Tyshchenko wrote:
> > > > > > > > > Part 2 (clarification):
> > > > > > > > > 
> > > > > > > > > I think using a special config space register in the root complex would
> > > > > > > > > not be terrible in terms of guest changes because it is easy to
> > > > > > > > > introduce a new root complex driver in Linux and other OSes. The root
> > > > > > > > > complex would still be ECAM compatible so the regular ECAM driver would
> > > > > > > > > still work. A new driver would only be necessary if you want to be able
> > > > > > > > > to access the special config space register.
> > > > > > > > 
> > > > > > > > I'm slightly worry of this approach, we end up modifying a root
> > > > > > > > complex emulation in order to avoid modifying a PCI device emulation
> > > > > > > > on QEMU, not sure that's a good trade off.
> > > > > > > > 
> > > > > > > > Note also that different architectures will likely have different root
> > > > > > > > complex, and so you might need to modify several of them, plus then
> > > > > > > > arrange the PCI layout correctly in order to have the proper hierarchy
> > > > > > > > so that devices belonging to different driver domains are assigned to
> > > > > > > > different bridges.
> > > > > > > 
> > > > > > > I do think that adding something to the PCI conf register somewhere is
> > > > > > > the best option because it is not dependent on ACPI and it is not
> > > > > > > dependent on xenstore both of which are very undesirable.
> > > > > > > 
> > > > > > > I am not sure where specifically is the best place. These are 3 ideas
> > > > > > > we came up with:
> > > > > > > 1. PCI root complex
> > > > > > > 2. a register on the device itself
> > > > > > > 3. a new capability of the device
> > > > > > > 4. add one extra dummy PCI device for the sole purpose of exposing the
> > > > > > >      grants capability
> > > > > > > 
> > > > > > > 
> > > > > > > Looking at the spec, there is a way to add a vendor-specific capability
> > > > > > > (cap_vndr = 0x9). Could we use that? It doesn't look like it is used
> > > > > > > today, Linux doesn't parse it.
> > > > > > 
> > > > > > I did wonder the same from a quick look at the spec.  There's however
> > > > > > a text in the specification that says:
> > > > > > 
> > > > > > "The driver SHOULD NOT use the Vendor data capability except for
> > > > > > debugging and reporting purposes."
> > > > > > 
> > > > > > So we would at least need to change that because the capability would
> > > > > > then be used by other purposes different than debugging and reporting.
> > > > > > 
> > > > > > Seems like a minor adjustment, so might we worth asking upstream about
> > > > > > their opinion, and to get a conversation started.
> > > > > 
> > > > > Wait, wouldn't this use-case fall under "reporting" ? It is exactly what
> > > > > we are doing, right?
> > > > 
> > > > I'd understand "reporting" as e.g. logging, transferring statistics, ...
> > > > 
> > > > We'd like to use it for configuration purposes.
> > > 
> > > I've also read it that way.
> > > 
> > > > Another idea would be to enhance the virtio IOMMU device to suit our needs:
> > > > we could add the domid as another virtio IOMMU device capability and (for now)
> > > > use bypass mode for all "productive" devices.
> > > 
> > > If we have to start adding capabilties, won't it be easier to just add
> > > it to the each device instead of adding it to virtio IOMMU.  Or is the
> > > parsing of capabilities device specific, and hence we would have to
> > > implement such parsing for each device?  I would expect some
> > > capabilities are shared between all devices, and a Xen capability could
> > > be one of those.
> > 
> > Have a look at [1], which is describing the common device config layout.
> > The problem here is that we'd need to add the domid after the queue specific
> > data, resulting in a mess if further queue fields would be added later.
> > 
> > We could try that, of course.
> 
> Thinking more about it, the virtio IOMMU device seems to be a better fit:
> 
> In case we'd add the domid to the device's PCI config space, the value would
> be controlled by the backend domain. IMO the domid passed to the frontend
> should be controlled by a trusted entity (dom0 or the hypervisor), which
> would be the natural backend of the virtio IOMMU device.

Hm, yes.  I'm however failing to see how a backed could exploit that.

The guest would be granting memory to a different domain than the one
running the backend, but otherwise that memory would be granted to the
backend domain, which could then also make it available to other
domains (without having to play with the reported backend domid).

Thanks, Roger.
