Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8292473BDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjFWRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjFWRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:20:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C85184
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687540807; x=1719076807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QL4qF/7vl/gPFY6PEWH1vY4M3T+kvtpMHfbr6n4/FhI=;
  b=kdSnhNJL3MQSuzDNe68osyM55IKVN+4foalbcRu8temYGubHLPqUqR+t
   0TXw0owk9B0GKPSAILnCxiJGdX3a70WHA4qR8wqnkRRBWrN6KDnyBzcfG
   EhPif7Y++548r3HrZXCyc98lLvcVR1FEtLhYwX/IrORGzujl0vRWc8uRv
   TRbfxcXGYmjHWcKq0tttqTl19brB75vpKMSiSfqL0MwsJEC4QG5ZwKpwQ
   epLsT+xvElVrxXExMYP38F5qI7nxNp4QWd9AV6eL1CZRRMMWl932jf1Pc
   eXzdY1QZnPHs7M+oEAkZuX4J6cmMd+QP3NPfkM0qAMQgCUIyyCzFeHoIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="350584605"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="350584605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 10:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="692736796"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="692736796"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2023 10:19:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 10:19:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 10:19:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 10:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7d9oJrQC4QS/I/FQtA+oouhTLKuu1nkwo1oABcT/qrLcWdxOYN8XRv1erRXe/KnkQC6WzCzvGVz64M5vJbbGb1iy/eEjyu05c4+0P0O1TlxtNBfO6HHQySa5h0TAtDbgdV1lWoqRJI7VXzgYOuEDtieOjyKaanXXAndRU03KSZZ6L9jf01AdLPvKk+s2kEkw+Ia1fNgeAG6m5EKJG+hxIve1Cu6gHb/Fzd/MblhxPWBuV+RumC4yt9mRF5bJAS/4BPVqp/8GZluiV5WWeFpsm6Xuk8FcmOrXR7uSPCBVGZmY8HAz+kl+Eme00lioKZMypiFDCqAZYDFgfXabg6cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEkngfQ/tf84WjPqYp5WQWLchnCW1QbGDqOQJ/vuGLw=;
 b=JoN60bQyI9NpeDqhb18xqgU+4o7kiui8dLSpLPYKIKMmEv/Daxc6/AaDdBxpdY1s9ptTVKM/tp6ZlxFX+kkVtUcyB2YqAePLGbNWIF6fIi5GCcGbt+sBeqfhDZ+wm0RgnNfMgnahBuGQ/PnWRwbld7bbAEnE4f1I+snpeMULBVP1EQrV71DN4EPmDmYSWTwUDIB0iYWTXS1/bDgjEe+UdzFIdOx8Il2uw9Qw9Rg10/6PaqMMcA29a2gbiAt/Dv+/SHvktXFEK1LG2BFbHKYHYLiOob8+JVWbch2yBCjSCkh8Eq0kYxt5H95xysMgpXNpzJxOSzAS977gdPhaTorgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 17:19:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 17:19:11 +0000
Date:   Fri, 23 Jun 2023 10:19:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <oohall@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] libnvdimm/of_pmem: Add check and kfree for kstrdup
Message-ID: <6495d40a1974c_4ccfa29497@iweiny-mobl.notmuch>
References: <20230622143800.31779-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622143800.31779-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 2115bdff-b392-455e-9608-08db740df5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ItlzJh2/qusrX0Fyf88SWCIYwBCQxUUBL+t8nGxPnvNhXQC0DN7fSMq+pTKloalsriJWhasdzBHZ/CdPs8TgrO1+kUnrepsqUrznBP3FgpBDaGYs3Ii5U6lmDzNpV0T4Y6d8zUP1pDKe7WHDN8KU3gOXRNEjMpEa3zXrNXXzTm7/zpHxOVzEaCTEmuWL5MsjH2kSbO1SA3PoXM3YOK9EVrJE7LNTMjScxpr8vHegmZdZm5e9hot4LpuHv63LmgJuCbE/RRk9treK6j19BDICKmSJmADgBm+hSxyw62B+lt6l4Tzy0z3sAJB/v6ZsQ8WKdIYCDfRdBxckXtd4ZxHueSr9b5BNnfSB12nR/u2JoTaLENBsanvhrzrX3G7VNQT0qFAbfiPXBh640Cle+0K3nDpyb7D+28sCgmjET/JCB7kfEteN0F8sHbRZhlWqqmnZNt0ScWvoSIa3utklKVuh72CnR34VdEWBDP5TbRY1LIjZK1XjYqDPw3LOH06y9XdVIVEfjPAxKNqpxF7mFydcD88fsU7Vvuj6TIXa1lD5jDd6if1uyeIDg76FDPZ2Duc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(4744005)(6486002)(6666004)(38100700002)(82960400001)(6512007)(53546011)(186003)(26005)(9686003)(41300700001)(86362001)(6506007)(478600001)(316002)(66946007)(4326008)(8936002)(8676002)(66556008)(66476007)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFvo3So+vREWgxoLbl+6YYMMVpgpQQ5tHlhUSX3f07OJYSCFkJtpJphMua6g?=
 =?us-ascii?Q?pwZhGuwQ5IaY0arBop0WYR20VCCajPo6f4DBgn+YmjuOSgPJX+HLb5kxhcUa?=
 =?us-ascii?Q?BiNOvQcqcjqm9uiDB6vlt+Ju/t+F9ZDBKMebGOZBku443y3KyHY/YubafI4+?=
 =?us-ascii?Q?3MUYb0VsAkeanbtWAcoOEbht7WhVu4AB/vPDEZeDfDVYNhjVnKcxBeZZe41D?=
 =?us-ascii?Q?hf9gui7AR9IMZZKUA1e5p0ydBs/tPqiI9mF80+3mnO3LTO0Gif1fFceBCbmM?=
 =?us-ascii?Q?BAj8hDljE83MAwbzRMEoj+ChoqjjuXsFgBEd6jMw9AiHxRT7JT4fdH9T4Cwk?=
 =?us-ascii?Q?0JMZImJRqNWXv63yiN0a8E4UGG84zmpHqsgy8vmxi9T4PtFIuEhXCY34peVM?=
 =?us-ascii?Q?LOk3p8cV8KmoZyipwnl6UaD+iak1xnRhgJ4rSYjgo+AZFAnblM1aTTV4D/Xa?=
 =?us-ascii?Q?use9QDEZVfKALnC5I7Ys1A70IeKQ66BEC+FcoEFiIkEZqfVEQa+NMqhEU5xY?=
 =?us-ascii?Q?VOvuOs9hNWzTmyfQyh50ZVbIqG4Hdw1VvkdpeXLHgXn/FtmQ9QsbqSxQXCii?=
 =?us-ascii?Q?0hA2VAIAB0Xy31KqClC5szLj1pRWRHTuyfPnnm5OhzdnBerTW2tM3DbrPo8v?=
 =?us-ascii?Q?pScynuOIGBmKsGuunfy8Piv9lIOw7UPokJ4yt+Jb+u/4YNzvbJ3OBijtwQsz?=
 =?us-ascii?Q?CybHUp0oeOf9qamEaxVze/iiiOCBjzCRHHH6hj284Kw4OeLj1uJ0GOI+LYuC?=
 =?us-ascii?Q?jMiBCFAg9CTc9UrKYXVSZnvFByJk0iej5TKcP2BwuG+GinmFB3JctSZbwtGM?=
 =?us-ascii?Q?256E43GxKSKB02o0bF+BGRJI6A+3bgJQA+nWLIUIswP4+gHkfgbf5Q0fquwK?=
 =?us-ascii?Q?9ngxOY3482ZMT9KvbvxOD1NQpSGs2BDoGMPfv1t6sIFHfCAbmAoL071oX91s?=
 =?us-ascii?Q?+Q8hHRS6VFBTwdS9pPWtLBsC/p+OZ1iWN7SNvruRnD8sfQQjZ8bRrP0p4O7p?=
 =?us-ascii?Q?Qyurtes6iWBwkrTE7mZXpiAAftOKFzvYdVhXkZfr4oTl6aaClKHKSpr/ZKb4?=
 =?us-ascii?Q?MSeyahVJgoTNcAg42IkNYGaZgwOc7di6FXfMG0g2lOXkkaJt5/aMioQjN4TK?=
 =?us-ascii?Q?yNHtZQ2nFeN8l1Drbe2RgZdSdLg9+RmnIMd2/XG09XH016Fhq4A5A2cRNHqw?=
 =?us-ascii?Q?68McBongCpMIntd3eKT4ZP4ZveBLsLSdFilHZxu4YWk0oMFJeY1hvlUi7HgL?=
 =?us-ascii?Q?2xjknPUpyFu/KY6D7QtNVoyxgdSDLI+LSHir/X14TtTr2PrrLLyDB/D4dJod?=
 =?us-ascii?Q?giG6q3nLiJYTikfPJGmLllVZwDCiBXMSGr6OeDNFzW176232jfPmwle9dsy3?=
 =?us-ascii?Q?7JDMZARlFXUJVM1c9n4Kp5D2nDpcTRYDqrB+YCWT9SLejArQz8DqhPaQeX9P?=
 =?us-ascii?Q?mWSpSK/lUd18umLenVq6ESunWOVe6uecQfyBLhYakh2o5MokCfgwYyEOesoP?=
 =?us-ascii?Q?2hvIH5BIxmGBtXLyrlj+B2DHVQoED5Ob0lfKflRxAt3D0y+PjAHT7Fn+bkEh?=
 =?us-ascii?Q?GBiBhMsMCyReth2lrDuwrTTt9fx5AlXZunmggpRj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2115bdff-b392-455e-9608-08db740df5fb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 17:19:11.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROS7BLDI4iBjcIZykae1mu4efxI1A1BBl08+gSoIMsBvtVQN8V+q3Dj9O7iZbVBQB7xLIffn96iYT7S+GzVIxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiasheng Jiang wrote:
> On Wed, Jun 21, 2023 at 00:04:36 +0800, Ira Weiny wrote:
> > Ira Weiny wrote:
> >> Jiasheng Jiang wrote:

[snip]

> >> 
> >> Nice catch!
> >> 
> >> However, this free needs to happen in of_pmem_region_remove() as well.
> > 
> > Looks like the mail from my phone had html in it.  Sorry for that.
> > 
> > This would be better with devm_kstrdup() and then we don't have to worry
> > about the kfree at all.
> 
> Looks good.
> I have submitted a new patch "libnvdimm/of_pmem: Replace kstrdup with devm_kstrdup and add check".
> Since the titie has been modified, I did not submitted a v2.

Ah ok...  But looks like we will need a v3.  See the other email.

Thanks again for trying to fix this,
Ira
