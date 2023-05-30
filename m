Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F5716FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjE3Vne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjE3Vna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:43:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555B118;
        Tue, 30 May 2023 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685483008; x=1717019008;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9ez1XEstzvrOGpye71W2r2ue/Z/4qCSUNazcCWTQ34k=;
  b=AMS/lcVvVeLxyVOCKHM3i13A8sA/lO+ASj+sjNqkD2/yGROMV/E+iK8B
   M65vPEt0COjd1v4+DNr+GT1n9JkJ9ILo70rNzhTc7jzts3lHIj0klhQy0
   ybLFXTBesAQGOnrihvVJm/tZsysjajtYEcd1CcIiyJ5mB+cCWMMQ7wu1/
   En52CbrYBWl6c4Mz30myQOjaDwEoRhrrcZ6vM7tPRAxLf5vixn/Rwt99N
   fnPYUfREp+ucLy38Hh88GLxsf6LES2eM7QnW+5TkMO/XlMc3wedC/81nz
   q3e57hW2G1dGBaOiO+kd3PxsrKLA20+ki/oJgM7GoKMzCGQWEWybLFrJ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420819919"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="420819919"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 14:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="657034599"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="657034599"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2023 14:43:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 14:43:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 14:43:17 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 14:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNiZKaFfAFkerYUwJ+Ap0lR4Prx3ClZBk9hXmQIdT2YkNlLof0xXEvRmoHSr23TuWzW/R5J81eH/qjkmUlx8z6816IkShrEKrLWXUULtOOu02L+9tu6CxGPqvUfoGXjZUl0xRY/ozusRLJ5pb9zMhXpH559bobrSogDnH+L8TfTwVOHs/48KmZo5DMztNc/OK99IIpe1mNlnaJYJ0mlxyfYdOsGCLnRj/ramcEZLOm/1Pz6GCiwykkHkBj7oYG7uOi61t38AtzxGUKviUPRypbRdcXXaGea0q05rMJxNWuSQCru0A4Fi3ItT8M0xSZ975KdMm/Z20tsqckbWZl78bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub9GsyqMlQ/EhXP+Hcv1oJF4Wc9Aa9k/QUuxHnt5jh4=;
 b=d+s9MbzgT+8kdKOqcePNmkOUOj+pD4+8TkdBGEd8Xl1eozVtz2O0/Ptof+4LQKK6sRrGKBHvXpJWrzgshxqwqHIM+rHkMHlrzBS3VV4Ou8nkX21V19rX9t2mRfSTSpEwTlreGoR5Ju/Tk+Sk5aDb9D8rEY10BgBXUe2+pnQDyUghHArdQk1QPQiH90UbSmpfBlanm4g2zisFUdfClhCjn3nKpBEdGuBPtZmRY5C60vM1w4NtiBjgjsKxDMROz+0oJ9fSGMUb6TpaYyzAtEFaquVUY0nq6DOOA7qMgrG6A9JrAFvaz+9Y7lb4vrUN8tnlBhPh7pzcDiqo9AijshO7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4744.namprd11.prod.outlook.com (2603:10b6:208:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 21:43:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 21:43:14 +0000
Date:   Tue, 30 May 2023 14:43:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mcgrof@kernel.org>
Subject: RE: Revert "module: error out early on concurrent load of the same
 module file"
Message-ID: <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: 43651223-e005-4070-b426-08db6156df3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Och1z6iGHufdUQeM8aRZvnffnKhnvDH3+cqz8Yu8YrlD5GZT0DQbmPgASNUTcGOtaNwowvSSfCUp/VQWWi2s8ZKhZh3azSuOo+jBFWAoZZifxuBJeBjWQQw8DmOpsCaBeYdlU12R8LX8f5ko/s+01tyXNfK4N4XgKAu9GzYFcu/yUCJ5oYP83Ao9vq3IPbiyuNLKbzjB/Vn2qKk0thB8h47uyn7nV9sv99pIeWVJfBCnU2aaN6CeV6YtzrlATr9PQ0LQg5hMxbG/JS1FdZ5fdDaV7+WkvQi3/PRnbSTJmr+bUABvw8c2oTpo5k3Q4c2I1JNXkVsdc8bM0DaLLVHxHWppxUngrAu64zNNIrEsuxuwrHA52AqmIAaIQxbLMMCpfO1UiQJ6ftBMHAT8BHaTNrKcQGJaRfwG2HgSIwqExCoBcvoWSluu72/RA0yhPhPni6kJp1pYubhHlTh69ycwSoP33TvgdKG9mkw3BJiB2yIZiRzZTKqhkiQtbtINHYBgaM3kdiyiN0nnoFhC/aDl29yq2NH26J8cnUE/RWOBWOHHwrSw5NOp4EQoMw/IR1Cw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(66946007)(66476007)(316002)(5660300002)(66556008)(4326008)(82960400001)(8676002)(38100700002)(8936002)(6486002)(41300700001)(110136005)(2906002)(4744005)(6512007)(6506007)(9686003)(186003)(478600001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8D/SipUPPDnoYHR+IdYj6ljJH12c1wikrTG1bONMWd4H7DyscGlcMh7c9cmZ?=
 =?us-ascii?Q?QLSLJAqAZKqfEBdzW4zBwXcETWxrILDmRWsu8bZo1IihtP6uFBhVNl2Dwxx7?=
 =?us-ascii?Q?tu+b36KcQdiIjj2NvI9aEad88CiN/naeqoyJbIRlNOqCAvPkFHlQI2JFpLTX?=
 =?us-ascii?Q?j75/7Bz9qbxaVx90yvRoOETcVs1L09R1zjVuCDMiPVBAPS6roe4MACSPEYwk?=
 =?us-ascii?Q?S38TGqnfLLppAtYtmLJ4xL3Od77DEbPzsIIUe9titRnfNwHRN6YqVucisgec?=
 =?us-ascii?Q?RjhsY3RaV3mRR5C5Q3wM1kVnmeRPe1WJ6pCHyKpvZFR4BQsYc9j/czLw2ubi?=
 =?us-ascii?Q?4vRg/5gn/bXzJrDVsmfrTH8PapyzhJPEPH4/XjBR9c+oSuy/Dkpe6VzJFwp1?=
 =?us-ascii?Q?Ns3GyOrIGVm6DjO17n0lCkwN8TmGqk8e7ZHdqyanuKnuUO7TuNVtRC7fxxfh?=
 =?us-ascii?Q?v6J0uqS6aR7lacjyzKsSZRXB5ickFrnHynUID4LqqgXgyWTSfQxG4ObbtxCL?=
 =?us-ascii?Q?Z+ZM9+i5bywZkBN+tOae9GSusujmCZ8YOQNoYpbQiyn0U9U1r0r6CLiqHiGG?=
 =?us-ascii?Q?7TX8r9hlcDp0SpA5vK/vDuBwfIx9mfcmZTMv+BZU19Xz1SyBb4eOw+XtrA1r?=
 =?us-ascii?Q?z/AX6aSL5S2r5hM0z1peUc8JnPuzdorvEWxKp14aYM8tMedRYh220CKFYRdY?=
 =?us-ascii?Q?ZcJs8k9aepEXicauJTchJu1KaE1sE7lKQIYTq0WLpwqPFjqXfIVjN8DOLe0t?=
 =?us-ascii?Q?swO9z9R0dGA/cQEPIocXvC6dNW81Vp8gfrij95U1VoI6bP3unckLyv4c/wN4?=
 =?us-ascii?Q?I/RmD+bH7eCsckVQk2HhEOt/vsSwcoASNhyQHUFIK+PP71QV8krlEdQMQNPd?=
 =?us-ascii?Q?vngWThCgK0mmvnK3fMlh0vDZ2HBjnMHMf5UrlnmFg56rkagaHCgXZvy6dKW3?=
 =?us-ascii?Q?UZr2iiOI68CrPPJm4EUvLDCn+zpffXiym/IVblsX6RYPvcwA+yz6Y3DW+tiL?=
 =?us-ascii?Q?G7ZNWw8weqGcnvUp/uj/Ir9PQZ2fgmndYI0aMrn1EELmvgjhDufVnwuWdVmS?=
 =?us-ascii?Q?PZUZzCvYEpcp0C7R7vmLjhOH5iZVfsUi7bhVx4UVlvH5+YFexnZRGtCgb6EH?=
 =?us-ascii?Q?Z/MaYGvtdIDKmTb/XNRGFAlJbWHz40JEkPHYIJPI+/WZ+5OMYIdGLB/snUTu?=
 =?us-ascii?Q?w5mggtA1KqMWMRfuBL7LJK0jJdCoTGVcNnycsvwjJD8uKGj5Rl1NJXRL6YgQ?=
 =?us-ascii?Q?asdfggwnBeDD+XygAPDnfud/Oo4YqLoclj1HBtWkj0Moxuwx4XMQsTg24fFy?=
 =?us-ascii?Q?NTxV470lZrnta0Fdt6gsoqtHE7m28Rx0KsJWOYSEy6Y2zi7qkOT0cZaz9oYB?=
 =?us-ascii?Q?yudCoRsp9K1ldSdIGHDP6gtrtmXOIh/1ByvKzSrq+P14benxNH9TcVrrHnJq?=
 =?us-ascii?Q?Ia21LatKhReiDharNruoXKLG6sLkG7DPzNZNVOfhSVPz3W1/VUMsPbfbxAn2?=
 =?us-ascii?Q?tgGOhKWyT8EFtjk0M6iPSottqUJwGByVHqVy9ab2za8JzwPehWjETD7wj3Cy?=
 =?us-ascii?Q?tSM69nN24JlZVYhRAhBNCU84loeYvorWQzO2W5bUtQciBZQRmeO5DvB2dj/r?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43651223-e005-4070-b426-08db6156df3f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 21:43:14.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY3x8ZbRDNzwgb8cfJHWv/JdUlMbi2WKEjyxjSb2p5aOZvBtq3NfVJ7ONoUbE+tzXxF2/vvWSTptz0KAFxHfIR36u+1Qt0PUHvZRM6tvWRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add linux-cxl ]

Sedat Dilek wrote:
> Hi,
> 
> after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> /etc/fstab).

I did not find a mailing-list thread for "9828ed3f695a module: error out early
on concurrent load of the same module file", so replying here. This
commit breaks the basic CXL smoke test of loading the combination of
cxl_acpi, cxl_pci, and cxl_mem modules.

Just wanted to highlight this a test case for the next attempt at this
fix.

