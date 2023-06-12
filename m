Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8CA72B775
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjFLFjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFLFj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:39:28 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F70E6E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686548367; x=1718084367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rDEzv1iaItuPHwBVQfmaW3rMV91h8noHaw81Z8U60B8=;
  b=WphKVmwBFbzRbv6Eh2Q4LJqOiBf9cGBf7bgfeDqB2nImBcHrReLVx0pw
   xN23hvc/k9Q9Yz05LiDTPwKeummzCVVzGdjzpBnKVHcoFqmLJuvW0W/Ew
   npA4J5pxFQI9JKvqy/NJeL6gZgUtJVru7GKJnxQNjZAqY1vwN2ueYEIbd
   6k5Q/w55mEWgoJA/x0tmIGBhwqy8Z2xmVVyNt9t+x5aJrIg0D9Dy9UPQA
   O2rCb6cslLczQBDA+1FT+TNGU8wdDwbztbXPRXkNplv/TuGees2NfcZJc
   1LZ44rLiBANkG7iryvaW5xgPXg3rIuXoigfZ6usDGgq0ddt49dN7dDeTR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="86915300"
X-IronPort-AV: E=Sophos;i="6.00,236,1681138800"; 
   d="scan'208";a="86915300"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:39:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVSwApLU6ZS3HMwicaLdk/K1tg1Omt1GLv8z09z8P0JRgw7MG69r+JT3YuxDMs3cK7ONCHvaPaFbmgyURmWc9Wgo/l14TIRe46+Q48DW3NfLn5UOITQywmFzLOJ1kMAvzNYZEMdImFvLOSNsoUQGyVqgE9PPOpLjc85rnXnMdgTK5z5oEz7UXwjMDXs84bn7mqQZ33ZxYPpKn1jemkloqrluj8brST/ZfhQ9u3DbaqYHfYmGy7WRnzrjw1SyoDYEoUfYxzKOKaWLJ0oLAMjrmPDl5M7BdVfZcL3ZN39+5AqefJ7guQPsl5z+sYSL6mlyc0Di4EX34CT6nuYZEmnI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rHRGwE1tW1V82WRWgp836vhTU+qcy6/6+I5u5NU+HY=;
 b=T6CJEhVEeq4tXyq3peDMTb12LyCMDICxZZoP29VwIh1j5HfKE1tJ/SaCUMWTUAjT3qa0eWvv8bKH9n6YuVaOj+s+BcfXaKIMr6SwBRS5WxFHa0e7JXk2Rc7gL2eUbQubdsSklD/3IxOFZ9wi9YBS7MKwAeDM6u6XkHK8969plOLIFP2GaXtM2OAMeGPANlRqKcQJZdnbv3T+FNSgF8kgusbCftwDoiixjdiqIRuic0Zo8bIdqOV4WS4BtRMLWY4zbQHJ+rwQeEOC4VCrdOBcjEmiTfjPbhMsQjGIJ7beg0bbSnp5mR4ZF734FlQgoUA3Xy5vc/m3r0DiJ5V5pVF23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB8210.jpnprd01.prod.outlook.com (2603:1096:604:174::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 05:39:16 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8fa6:7b20:a48:5400%4]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 05:39:16 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>
Subject: RE: [PATCH v4 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Thread-Topic: [PATCH v4 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Thread-Index: AQHZjzMyw+/aF6UzHUqOyccin9rgsa+GvgFg
Date:   Mon, 12 Jun 2023 05:39:15 +0000
Message-ID: <TYAPR01MB6330D9919539D40ADA52B6228B54A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-16-james.morse@arm.com>
In-Reply-To: <20230525180209.19497-16-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-06-12T05:24:47Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=8cf85e60-dd09-492e-978d-b48e41d8a09d;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: b917f2d14508431a855e2af82b7f1d8f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB8210:EE_
x-ms-office365-filtering-correlation-id: 234a460d-9d83-42a3-e69b-08db6b075c2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LAIueKWkBl1RHNeDUtDsbVaWyRDFX2zNiArwYMhjkByCsan7r07bcRtrJhiV28qfoVy/5hAtyZ+wgeLe3TQ4Ycu8BVidmqeHqHdX6PX2ORhPzto/jlICX9/9+rpr5JLhOMrdyRrlAqRW49daiZ0SHVRlhpbalRU1UbDD1s0ondA/0x3g2z/0VAr9YvsDxCB8oLroJfADq2PfE+iHisAUlGn5XJ7l7ebP9p/0NPWS75Y1twcmvgqnW6cesjva7DqNH/dix3KMXOA7YYE9err12wkcv2MBDCG2D6yNHrM4kCnXYy29MKnaVBkS/2nbqBbT47p3iIJBEJb1/+c+ovCXhSNou4/GoJ04764kLiVZAolmWXoWOMTPQb/+lIlD/Vr/WllSXIOZgtDdmcS19lGliIpmBUm8QnxWCf8dOZtYMOLIjyD3lQJhvwPDT+v19ozpUsGKt9TDkYWqed1Uc8Z9st7ru/cEvh2EjDCJyCwCwgjM5duaslk/9B1a6LTp/Aitij+O8Wf3mDKgqE58o8T+ex0MYp6O67MfUfFbkSO8cmP56uOy312mpg/mxAew2Ybb9CdnEPDfYoJ5BjJIQmvpBsphxFK3AzbpggoWKUeYTRQOIpKPKh8SflJeHcbJreVJuLbLvwIYg+Oo9WqXjOt4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(1590799018)(451199021)(86362001)(7416002)(7696005)(316002)(8676002)(41300700001)(82960400001)(83380400001)(5660300002)(26005)(55016003)(85182001)(38100700002)(9686003)(6506007)(52536014)(33656002)(71200400001)(122000001)(8936002)(38070700005)(66446008)(66476007)(66556008)(64756008)(4326008)(76116006)(66946007)(478600001)(186003)(2906002)(54906003)(110136005)(1580799015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?L2oyQzBGbmJ4Z0JOTHFNT0ZQem1GRDlQTVk1RFQzNTkwU1lkVnpleEdZ?=
 =?iso-2022-jp?B?ZEFaWC9zMUdBNW1pOXc4YzRlckhvZDIvQXhFU0l3ZHVKVzJBbk51Rmcv?=
 =?iso-2022-jp?B?TE1TR0JycmhLUWFxWjFoV2JPUno3M25OcDhKeERIeVJLeWt1MnNlOXJn?=
 =?iso-2022-jp?B?TnFzbVNWSlY5TnBQdFVOR3RPZUJyVk9IYlU0Vi9rUWhpN0NvN3k3Q1dq?=
 =?iso-2022-jp?B?TlZORUpzZDQ2SW43ZEFDRktPS1dmYUdpcjNkeWJGRXNpaW5VSWtPYitt?=
 =?iso-2022-jp?B?Nm15aitjN0xZaVFGY0ZIYXJBYmZkMXY1K0hReWtpVTZHRkFSUVpaT2k1?=
 =?iso-2022-jp?B?RzllYi83NkZReWdvM2l5WUNsYUxQTURCeEJrZ3dCWWxaRWZWd3FoZ3lC?=
 =?iso-2022-jp?B?RExmNThON1YzMjlXTnFVSDh3S1lmYi9Ha0N0UVkyK1ZVeGVHQ0tEZ2VL?=
 =?iso-2022-jp?B?c3NLOUhRZmordzIyNDdIOGFsZnRyRUN6akkwWStNS0JBUmZXeVFSbGhZ?=
 =?iso-2022-jp?B?YTlXQmdrNkpnaVZiUldmRUdBaDM0VWtLY2VUb3RFRXNORUlna2tvNDM5?=
 =?iso-2022-jp?B?bFZQRHBXTi84akNnWVNXdXBTQmM3cFlOSmhtdHRoY2UwTmJWZHFOQXNU?=
 =?iso-2022-jp?B?UHdMLzBVN21HblFKRklVT2JVWDNaVDB2dmhnc293YzNyc1BtTElMaUIv?=
 =?iso-2022-jp?B?dFpHZUMwUHlVVmZWcXF2N1J3NmlJdEsxMWl3WTNQZ004R3FWb3hmRG5D?=
 =?iso-2022-jp?B?azJyL1RzdUFlQVhQYkNZL1hJWnFvcnRUKzI0bVhhcUJkV1l1RVl6SlBJ?=
 =?iso-2022-jp?B?Z2tudnlaV0hrdjdpRTcvMFBLa0k4dzVzeXhlaTM5anVsbHkyWUtwWWlt?=
 =?iso-2022-jp?B?bXprNkZlM1llYWpHdnZXNHZuWHBRNVo4NVFxOFMzMEpJS0pQanNUM0tq?=
 =?iso-2022-jp?B?bzIrRWFPbnZRV3dtUm9PWkNJdy9EYXhrWSsxbFloUDNuU1M5SHZaK0di?=
 =?iso-2022-jp?B?cXhFQ1lYM0RaUDhxalhsalhWT0VDa3A3dFp2UVU0RTVzWEZMK0dNd3Nt?=
 =?iso-2022-jp?B?akZMSDRONmNjdjBocXJsaG5jamNFMjhtYnZQZ3QzNVNmNEVMYVNOUWNV?=
 =?iso-2022-jp?B?Uy9LMGo0dE5yNStVQXNFVnZxRlZvQXdFWVRVU3NPZzEvbnE1MlVETmZK?=
 =?iso-2022-jp?B?ZFlycXZtTUZublVmeE1tcWROSm9KNDlGc3pubG1jcWt0MmY0K3VNUHda?=
 =?iso-2022-jp?B?OGJJVTVBUlZmVmxhTVQ5V2dmSHdpU256VHRuclZtVkhyaFJjdmtxSllP?=
 =?iso-2022-jp?B?cGFkeWFzbytpWmNNaDMvUjFPeVN0aGpIZlhzdjhQMXRFT2FmOEhyd0F6?=
 =?iso-2022-jp?B?MVFTZDVkVG1mZFRNUklxdzJXcEFobExWSmtkZ0VvU3FzOE1UVTNINXBt?=
 =?iso-2022-jp?B?TFJzdUpiejE0c1JNWEIrS2hqcGZTMHJsQkl1dEdlQlo5c1ozb2gxUGdY?=
 =?iso-2022-jp?B?NXIybnlCQ0dvMDdVcGozWWJFSHlkZktLSnRnTHVFV3JWTFlBRFBHcmU3?=
 =?iso-2022-jp?B?bmlERERCZG5iMVJEdlJOelNwRS95QjIyK2JmUjBkUUpLRllqTlhIS2ZV?=
 =?iso-2022-jp?B?ZEF4d0FUd3l3KzZsRHlwd0hkb3BMZHh6b0RzNkxpUEp1SjVkM3B1MXFn?=
 =?iso-2022-jp?B?QmM5empHOUFjclFGcG9nWm0wQ3RPdGtXNXhBcVpjVVU0aGV1VW16MGhO?=
 =?iso-2022-jp?B?VTZLYkE0QXRlNUkzalNBczVoeWluRmRUSUg2VHNSUjdsYXBDN2FydGVV?=
 =?iso-2022-jp?B?MjBQd3lxSW5xay9Lbnk1VzJOckhtMU00OE5yYXBZZzdmSFdUWkdsRklY?=
 =?iso-2022-jp?B?a2RyMG1FZlpRbHpla0d2eVJ5NjlGNkt2aDJHN0MxOWttSEM4bm5EaENM?=
 =?iso-2022-jp?B?TlF2U0VFZm9ta0Qvamc1TlEyWWZqbnBkbGtZNEtYUVBDYmFacVc5SVhv?=
 =?iso-2022-jp?B?bVlGN0RmVXo1b2FTeXFJeFB5SjR5MlZEc0tkRE5PRG5Oc0R1ZnM1ZDNj?=
 =?iso-2022-jp?B?NTdzdHRndSsxbVd1UWMydndHdjVxdm94S2hFTGRDaElmS2tYNG9qcFh4?=
 =?iso-2022-jp?B?TEsrUG5vNkpzejRYMkVIN3hFZkxBc1J1bnBOQ2lxaEx1aXB1U0htNHY0?=
 =?iso-2022-jp?B?RlZjckFseHFYVU42dDlIbkxXNEluYWd6VjAvTDRBOGM5N2FTcEpzcEdl?=
 =?iso-2022-jp?B?bkx0cGlmNWhkTldqZC9idmVObEVFM1lPUDhuTDRGUU54emV5T2oySTl3?=
 =?iso-2022-jp?B?aWJ3NkZDL2RUOXQ0cUNhMWZUeDIwVi9ueWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?SDdjSktLU3kwQXJVaTZqTGtCdUlucVJRNXcyQ0VkT202V1JiS0JpNm5S?=
 =?iso-2022-jp?B?dGpBb3FFRGZ2YW12NVZYL2VSb1dGQWY4TnpKdlY1cENGNlpEc2tWUFZX?=
 =?iso-2022-jp?B?bHN1Y29yU0V6M1FMY2trUkNhTVRBVjNucnNGWXpFTmRxdWRYYnVZeWFZ?=
 =?iso-2022-jp?B?T01scVhvYlNXVkd5WFpKSXFKT29wZ3Vqck1qdUphZVkvMlZUL2FiU2sr?=
 =?iso-2022-jp?B?R1hJZnRzcktwTzUvY2x4dmt4QWRONHlFUXJGM3FoSEI1MitGVXBvblR4?=
 =?iso-2022-jp?B?dnlRaWdPbFZ3NFQ0Mkw1YVNQUTdFYVp1RkZFeTN2ZFR1aGI3N1AxNkdJ?=
 =?iso-2022-jp?B?Vnl4K1IvKzJvUnpNczJ6SlNmeXVlZlVpd1NYUnZ4TFpkUExVVTNXaDYw?=
 =?iso-2022-jp?B?STh5UkNsdm1ZUnE0U0s1SW5yLzdKWkhHRDlLNkRDRGxLbUVHVnVLN0N3?=
 =?iso-2022-jp?B?bkI3TlpidGs5OUpJNmIrVU9nbGdiRDlQMVpHUG1QZVhYOVFZSGpKYnhs?=
 =?iso-2022-jp?B?Uk9hMm1rSW5PbHVSQlI3OWNHWlh6b0ZQN052Snp1NGxRbGZLZW9XVlpY?=
 =?iso-2022-jp?B?dzZTYmJWbkdkNnN0Z0hjRGM1U1EwbExtZFNDMFQvNTNhYmRRalQ0K1Bu?=
 =?iso-2022-jp?B?Rjh5MjFjOFFTZ3BjcmxZZmhibVUwdmhDODAvbUt0ZVNwODlZRGU1YkZQ?=
 =?iso-2022-jp?B?bERISGZob2ZpOEoveTZtaWZqL1NVV1U5endwSFdXR2VDK0twdzhoZmlL?=
 =?iso-2022-jp?B?ZnpNRXF5K2x2VDdZNmhLZk8rUUdTc00yYnFSNlhmQmpTQUVRUGp5UHpC?=
 =?iso-2022-jp?B?WWMzK1o4Q24zODBLL2xBVmxaeXMrR2ZMa0R5Qm9iejVRbjA5SlJIODRl?=
 =?iso-2022-jp?B?aTJhOWdTQzhCTE5JSS9xR3hIb1FEV1FIMnBMOThZQW9QN3lWMWFKOWdz?=
 =?iso-2022-jp?B?d2w5dGZKZE85Qjl3amwrR1V3NTYxQW1NT2VsblZqUGphN3EyaHBRQmVB?=
 =?iso-2022-jp?B?UEVycDYvNVRRRWkvZ3NPRWlQWXllTDNMU1g5NExEUVFYUjhtQVFHbmZI?=
 =?iso-2022-jp?B?dkU3WjB5cHN2MnRsU2gvRDRGejZWdFplTjRFY25QVExqSXcxSnNERThJ?=
 =?iso-2022-jp?B?aDJJTWcyM09Kd2JYV1VhWmIvdUhvUmkvOXZNbmFQV1lzNkxuQXQzalo1?=
 =?iso-2022-jp?B?TUN1UDRMMlVCR1l5b2tScU44QWw4Q29BRHNkR055ZXl1cVdac1hLZDZH?=
 =?iso-2022-jp?B?M0xLVzBOcmk0QlNOd3ZVYlhyYWJCZ1plN1h3dGczcmJDRjVuZ2pyMmFS?=
 =?iso-2022-jp?B?MEh1NjNHaWp6QjgrenI5b2x3emVxTG94Y0MzVW1GZmxRZUpxTjhPbUR0?=
 =?iso-2022-jp?B?UnJDUDZhVkxqcUJ6VEJKV2V3VDN3VzZoVVNXZ1lnTmNoakMxYmwrUnF5?=
 =?iso-2022-jp?B?RUpyUG9HK2dnRlFsTGFUOFYvV2xmRm9teWhzQ3JuUlVnbVZISk9OQ2xu?=
 =?iso-2022-jp?B?NmZGYXRHeGo0VE11NmxtdXo4emdtVzZRUUgxUmVrKy9jTElteVhnVi83?=
 =?iso-2022-jp?B?aHZkZzZ3UTRHYlJ2NUh5MDFRV1IrMzZESmsyMDFyLzA1cUkzQllKOUJD?=
 =?iso-2022-jp?B?cWtocHRFclJmLy9UV0d6NExKZkI4UmJyc1FhWjNIc3RuSUNDKzRLQ0hC?=
 =?iso-2022-jp?B?RFVPMXZpeGJ4NzZJaU1KbTNnOHZMRjJXYUt5alVZN1RMSkVkZFRlUmZY?=
 =?iso-2022-jp?B?U2ViOWN4SVR1eURCTnEvZVZDYUM3bXU2L0JOYzdLc3Y4eGJGR3AvcTZK?=
 =?iso-2022-jp?B?Tm1EcTFEdGQzWWhXV3BOLzc4TkFlYkR5RitHV09WVmdFZ0FyQnhvMUJh?=
 =?iso-2022-jp?B?RnVHVWc1bWtQaVpGNXhOUy9MbXdNPQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234a460d-9d83-42a3-e69b-08db6b075c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 05:39:15.7771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t36Z7svoQ76OlYJbc4UxbggKc3XaiUXeRS43N6TAp8kbM8J/OzkS8cw9MTlFqnDscUbQu5YneWP83q5AwiGhhkO8jCkQRaVYfbSTA1XcvZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8210
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,


> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a conte=
nded
> resource may involve sleeping.
>=20
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains, =
the
> allocation should be valid for all domains.
>=20
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems, the
> allocation should be valid for multiple invocations of resctrl_arch_rmid_=
read().
>=20
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper can be
> called on any CPU, and can sleep.
>=20
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ----
> Changes since v3:
>  * Expanded comment.
>  * Removed stray header include.
>  * Reworded commit message.
>  * Made ctx a void * instead of an int.
> ---
>  arch/x86/include/asm/resctrl.h            | 11 ++++++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++++
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 26
> +++++++++++++++++++----
>  include/linux/resctrl.h                   |  5 ++++-
>  5 files changed, 43 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 78376c19ee6f..20729364982b 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32
> ignored, u32 rmid)
>  	return rmid;
>  }
>=20
> +/* x86 can always read an rmid, nothing needs allocating */ struct
> +rdt_resource; static inline void *resctrl_arch_mon_ctx_alloc(struct
> +rdt_resource *r, int evtid) {
> +	might_sleep();
> +	return NULL;
> +};
> +
> +static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int=
 evtid,
> +					     void *ctx) { };
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>=20
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 6eeccad192ee..280d66fae21c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -546,6 +546,9 @@ void mon_event_read(struct rmid_read *rr, struct
> rdt_resource *r,
>  	rr->d =3D d;
>  	rr->val =3D 0;
>  	rr->first =3D first;
> +	rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
> +	if (IS_ERR(rr->arch_mon_ctx))
> +		return;
>=20
>  	cpu =3D cpumask_any_housekeeping(&d->cpu_mask);
>=20
> @@ -559,6 +562,8 @@ void mon_event_read(struct rmid_read *rr, struct
> rdt_resource *r,
>  		smp_call_function_any(&d->cpu_mask, mon_event_count, rr,
> 1);
>  	else
>  		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
> +
> +	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
>  }
>=20
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg) diff --git
> a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 7960366b9434..a7e025cffdbc 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -136,6 +136,7 @@ struct rmid_read {
>  	bool			first;
>  	int			err;
>  	u64			val;
> +	void			*arch_mon_ctx;
>  };
>=20
>  extern bool rdt_alloc_capable;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index fb33100e172b..6d140018358a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -264,7 +264,7 @@ static u64 mbm_overflow_count(u64 prev_msr, u64
> cur_msr, unsigned int width)
>=20
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id
> eventid,
> -			   u64 *val)
> +			   u64 *val, void *ignored)
>  {
>  	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d); @@
> -331,9 +331,14 @@ void __check_limbo(struct rdt_domain *d, bool force_fre=
e)
>  	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx =3D 1;
> +	void *arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val =3D 0;
>=20
> +	arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r,
> QOS_L3_OCCUP_EVENT_ID);
> +	if (arch_mon_ctx < 0)
> +		return;
> +

Would it be better to use IS_ERR() macro?

>  	/*
>  	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
>  	 * are marked as busy for occupancy < threshold. If the occupancy @@
> -347,7 +352,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free=
)
>=20
>  		entry =3D __rmid_entry(idx);
>  		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
> -					   QOS_L3_OCCUP_EVENT_ID,
> &val)) {
> +					   QOS_L3_OCCUP_EVENT_ID,
> &val,
> +					   arch_mon_ctx)) {
>  			rmid_dirty =3D true;
>  		} else {
>  			rmid_dirty =3D (val >=3D resctrl_rmid_realloc_threshold);
> @@ -360,6 +366,8 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free)
>  		}
>  		cur_idx =3D idx + 1;
>  	}
> +
> +	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID,
> arch_mon_ctx);
>  }
>=20
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d) @@ -539=
,7
> +547,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct
> rmid_read *rr)
>  	}
>=20
>  	rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evti=
d,
> -					 &tval);
> +					 &tval, rr->arch_mon_ctx);
>  	if (rr->err)
>  		return rr->err;
>=20
> @@ -589,7 +597,6 @@ void mon_event_count(void *info)
>  	int ret;
>=20
>  	rdtgrp =3D rr->rgrp;
> -
>  	ret =3D __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
>=20
>  	/*
> @@ -749,11 +756,21 @@ static void mbm_update(struct rdt_resource *r, stru=
ct
> rdt_domain *d,
>  	if (is_mbm_total_enabled()) {
>  		rr.evtid =3D QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val =3D 0;
> +		rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (rr.arch_mon_ctx < 0)
> +			return;
> +
Same here.

>  		__mon_event_count(closid, rmid, &rr);
> +
> +		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid =3D QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val =3D 0;
> +		rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
> +		if (rr.arch_mon_ctx < 0)
> +			return;
> +
Same here.

Best regards,
Shaopeng TAN

