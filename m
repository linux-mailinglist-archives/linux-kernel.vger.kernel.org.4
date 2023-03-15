Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC46BB617
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:33:39 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E3F751;
        Wed, 15 Mar 2023 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678890818;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EBbTrYjhN2Kr5AVtPGXMgm/fUG61JwkEEbYsSKN7wlY=;
  b=CkTrJs2GeSF3Xgmip1hWUWZx7U+7IIKaVVKa3ie3VNCQgqcKFSWkxExn
   hV2+WnuA03QTc9ImK4VROuisdk4LV5SwNMfe+0FHzQ4loCmfqwB5zt/Wl
   beYNZWDk2EMRVO99mqhYVrgUGK5GoCcs8hujoVr3CndCHb/+FnrpqEz7L
   s=;
X-IronPort-RemoteIP: 104.47.57.168
X-IronPort-MID: 103382471
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:wnQHUajdrD9GjbBcu73xUS7NX161SxAKZh0ujC45NGQN5FlHY01je
 htvDGmEPa6Namr1eY12bozg8UlTscODydcxGVQ4pCAxRHkb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWi0N8klgZmP6sT5waDzyB94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tRDeBNSMQqqutmT6++HcONmieEnB8b0adZ3VnFIlVk1DN4AaLWaGuDmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEuluGzYLI5efTTLSlRtlyfq
 W/cuXzwHzkRNcCFyCrD+XWp7gPKtXqjA9lCTuHnr5aGhnWd/VwqLEYQf2eJsNO9s3+DV+xCN
 Wgbr39GQa8asRbDosPGdx+3unmfpTYHRsFdVeY97WmlzqvS/hbcBWUeSDNFQMIpudVwRjEw0
 FKN2dTzClRHoLCTDH6Q6LqQhTezIjQOa38PYzceSgkI6MWlp5s85jrFScxiC+iylcHvHi/rw
 CGiqzI3jLEey8UM0s2T4V/Dkxqop57UUhQy4ATHGG6ohit8ZYiqYKSy5FTb5OoGJ4GcJnGLp
 FANn8mT6rBIAZzlvCCEXuhLHLiv/PuDGDndh0N/WZgn6zmpvXWkeOh48GEgDERkKMAJfXnue
 kC7kQNJ7bdBLWetd+l8ZIfZI94jw6HtEfzmW+rSY94IZYJ+HCeD8SdkTU2dxWbglA4ri65XE
 YmWd8WlEXsBCeJ/xT6yRv8U3b4DxyYiyGeVTpf+pzyu2rqfbXiaYbcddlCJa4gR6KKCvRWQ+
 t1HNuOUxBhFFu7zeC/a9cgUN19iEJQgLZX/qsgSeuvdJANjQTglE6WIn+NnfJF5laNIkOuO5
 mu6RkJT1Fv4gzvANBmObXdgLrjoWP6TsE4GAMDlBn7ws1BLXGplxPx3m0cfFVX/yNFe8A==
IronPort-HdrOrdr: A9a23:5DBA1q4nmB6GjwJCSwPXwAzXdLJyesId70hD6qkQc3Fom62j5q
 WTdZEgvyMc5wx/ZJhNo7690cq7MBHhHPxOgbX5VI3KNGXbUQOTR72KhrGSoAEIdReeygZcv5
 0QCZSXCrfLfCVHZRCR2njFLz4iquP3j5xBnY3lvhNQpZkBUdAZ0+9+YDzrdXFedU19KrcSMo
 GT3cZDryrIQwVtUizqbkN1OdQqvrfw5evbXSI=
X-IronPort-AV: E=Sophos;i="5.98,262,1673931600"; 
   d="scan'208";a="103382471"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 10:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPtVbLfOXl8NLL5Yt6flw/lBKLWcwR9sOAAZfYOB29ZtjoBl7pS6Nc9ENQNQ8ucqgkPH6wHo7jZ/wzcTMdU6SdKfcRgm9t6Zw3xcuoBHuOYncdJGYWkGL3eI4M/Jnu+WD6tYLsMVWf9SXRaUZnDcS3ss4MbOw4Bfy7SSkCLX49RhyNAd+wn2tqZn1me6++ZrfIxvfxDstRI97nWOxrfuw3Md469ijPKLK+yr+DBc6gO9Nx3/72WSP73NuVQLsg27A1VzqDEdXDmC9CUI5MZ+id4Ud/BMB6zjIdTLiEpScrJtAH08DJidyRYM9/e0XsUfnpZFEInOCrMVQozQKri2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPb1dFw727l7l7t5cvQNUTxsDNS6+upcubb7EeQzli8=;
 b=hJlcBrCFW/JFLBRRru7WWfLYBwFqYN+Ttl7M358vmAciGCay/E5134lGmkd3P9tsYr0wfuGU4V1WeHJ0pW+0drbdG4XfaNLr4fMVL9fwA6Pmfa7dPFgwj9RiHzrzHXp7senxtD9Cy6nAWNXh1octsNHYKuQBADUBxVGq+kxKAHsQmawP8kc33GDns1jcbTDAS0+TyvViL/EYhl5xAOftOHlOjFYpaC8YKM+JcZ62iikPtQM3Pwxz6rzeEzkESoG9YbKPuTWPnT+zc2xd8ci4gH8Ehrvo/DsEWrx2qAyIuDZZYjcbkyBb9MU4GJE7MC6gEqwZFPISgLegJeZODaYBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPb1dFw727l7l7t5cvQNUTxsDNS6+upcubb7EeQzli8=;
 b=cKiyhAwklq5RVJRKTVbHaPgBNEaxwkT9JzHiOF6fm/bK2UvQ74XVpwXG8eMlOc0D1uGjq6U+8r6/UC+izUAF1iIN8wthPTYtG5vv+wMzw8qeJo1EI0zhtwOgcJgM1srgLpLNOpDc2wyaASJCZP4gmIhSXYkSKF8NJ4lb0/LWSTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from PH0PR03MB6368.namprd03.prod.outlook.com (2603:10b6:510:aa::21)
 by SA0PR03MB5644.namprd03.prod.outlook.com (2603:10b6:806:b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 14:33:33 +0000
Received: from PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034]) by PH0PR03MB6368.namprd03.prod.outlook.com
 ([fe80::4fdc:e60c:b790:d034%5]) with mapi id 15.20.6178.019; Wed, 15 Mar 2023
 14:33:33 +0000
Date:   Wed, 15 Mar 2023 15:33:27 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <ZBHXN/tgrQFghG4O@Air-de-Roger>
References: <20230315121031.22450-1-roger.pau@citrix.com>
 <c9eec213-3c93-62ba-1f46-1e502f121eac@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9eec213-3c93-62ba-1f46-1e502f121eac@suse.com>
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To PH0PR03MB6368.namprd03.prod.outlook.com
 (2603:10b6:510:aa::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6368:EE_|SA0PR03MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: cda26bdb-f20a-4ea9-b118-08db25624103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dCrtoh8YBSoL2vpROJGDIgQkbQD6zbULIUt+bExIni/Dv0A51IwnVnb9sK1HPgABO2YIUNtcYFxrrDrGxRIUqJy+LPSPR+73VZG/2NNqsSRM7LiHKtlChFHRtq8XFfpUXyD0IhnU+N0iFAP2kd4KAYVkvkgi4KlU4cyev8vAhy+DYkbcD5q5Yqe72Xig7psoCqo5pJbUijY0sbkbg4mZOPuju+jf6Q2KTmIs4/giuL6BDXYGspn33723vXDtl2IWy1jBsm2ZhPhqjNMaIyHL2cHGp6uYAkH84R6n2lrB9FXdYnjpF/qvdLHlGrxz6qDP9QCmWTv2usayu+OfH4ngnkkryTlPuWAZR/zp+iF+UJW7x0Zz+RsDZp15xghnltpNokC9SEo/mIRIXWtQeM7rIOFSTErMFypE0ubba+i/iSXPzVK7CNqWcQQldOlW8Ta6Ic8UOBWu8BFPhpB9T7FCDUJN94O4/k1L/cxaUeYjuClmmIQX5PxE8mO9ByR0M6+b6J8wQVY2DLaNY5q8M8ckqc/M6mCPdz05y8OUps4VhQpU/KmjSCleQlB6y+GQn2PGp41vq0V4RLQXx6jw9mZDtkSJPB3mYrhBXYE1lqliiGeSFn/MNIHsUdAKCgggeuWYMXWW4Q7Cq1SeBHo5u30GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6368.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199018)(478600001)(66476007)(66946007)(316002)(66556008)(8676002)(5660300002)(41300700001)(4326008)(7416002)(6916009)(8936002)(85182001)(86362001)(54906003)(6486002)(6506007)(6512007)(2906002)(82960400001)(53546011)(6666004)(186003)(26005)(9686003)(33716001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDB6YWlVU2NGTTc1UndlSG9jczkxREUzL1p5QXkzS0tiMVowYkdBYUhPejhR?=
 =?utf-8?B?bi8vV1JRWGpVNnNST1pEUkRJS0dzRkNMSStvZVd5cmd4bmprbUpNZ1dnY24v?=
 =?utf-8?B?eTlJQ2sza2tBd3VyMk1kTWVyaWZlaGh3Q1JsTXFRWUVkbWlZcWtYWWgvOUJG?=
 =?utf-8?B?TEpodVBDVHpUdDFHRGhuWUR2VVVDVGc1akgvN0lIUEloYnlnZ0l2SERrcFRI?=
 =?utf-8?B?MnFaQ2JralFKQ2FtUFBReVdLclZLaUZwR2VzRitsaFl6V29ESjltandHOEJz?=
 =?utf-8?B?dmJSTDh4MzBWbmdLSDl0Vm0zdFkxd3hLV2F1SE9DNUtibkw3NGhYT0ttNEF1?=
 =?utf-8?B?TmQrbGV0bVJhMFNka3BRUWtlSjFwVkRjVnpwTFVUSWhXbHYvK1labVE4a0lU?=
 =?utf-8?B?bkxhNE9EK01nTlgrQXBleDBZWVhuQWluVEtoVVYwR2U2eTNES3VpU1JTdTZx?=
 =?utf-8?B?bmN3Tk9CMndHTmxDeFkrT1VwbWkxODdrZll0NXFUTDBMZUduUy92UzI1QjFk?=
 =?utf-8?B?S0ZkcmVVU2s2cjFNai9zYnA3VkZERHBscy9kMGpZaW4wN2NxbUhOT0pLalJ5?=
 =?utf-8?B?R1NSaEUwdTdoQmtndUZ5VlNxMnFkcjk5a1BwdThNcHcvdHZzdWo1ZmdUdE9h?=
 =?utf-8?B?anl5eDEyeURoYzFxY0kyWWV4YVdzUVFaR3pxSnRZcHJMWHZ6Wjl0REVrMXdQ?=
 =?utf-8?B?Z2I2bmhIMmRRQjZoaGxDL3VUTnFHbUpESWd6c1BGNThpcVcxdlhJYmlzTXRv?=
 =?utf-8?B?M3dGN1lmQmtNdWhpMXJKVkpNeWlkcnVucytwNlZHdTNTd2NXcXJGa2dFZzJR?=
 =?utf-8?B?WDEyQ1doalMzVFhpcGU3MzFMLzYvYjFMMklUQ1dFT013WEFXckJERWtXTHJz?=
 =?utf-8?B?WDJaZFdwOTBUazkvWmpCdG1GWEEwVDFYZXVtN296V0VxYWRncG5SM0hDTGdR?=
 =?utf-8?B?ZG85MHJqYVl0akt4REtXeHhnRVhwUzRKZUpqOURrNXpKMHVaS1d1bWpEY25n?=
 =?utf-8?B?RUtaekNGbjdoZDB0QjlHa2ovV21yNlhlQnBENHpEd1ROdzBTZDN6QkxUUytt?=
 =?utf-8?B?SERWRmx6azVaaGIxRXZFMG5XbDNIRkJKSGQxZ3hHNFFoSjVQWlB3QTR1L2I2?=
 =?utf-8?B?aFYySlF0b2NlaUNtTWF4V3VVSUtiRXVRb3k0S1d6YU9FT3M0OGk0TGRYa09w?=
 =?utf-8?B?MkpCOHBWNjl1SlFJcFFMNS8rVnlzclQyZkdhUnV1VGsyVzFhd1FUdFg1RkVJ?=
 =?utf-8?B?OXRxTGhnOXBpK1JmMVE3SWxIMGphTDFVY1pkZjVrRHZQTkFpYlJIaGxQRXcw?=
 =?utf-8?B?b3RNazlMUElDODBFVk9pRS82bldYUkdOZkJEU2pwZWRVMHNYeXUwbDlWc1hw?=
 =?utf-8?B?TGRiQ0hIUXVqVGt3NnM5M0t2bmdEM1p0ako1V1hoNTlsNE93U3lLKzY2ZW80?=
 =?utf-8?B?WDBYMUpYUERXM1RvTHZJQ3JNOFFyRXl0VHhmNUJIWWZUT3c3WjRNNGN0TUVq?=
 =?utf-8?B?VitrWGZEWk1scVN4RjNHMkFTQ2VhTWNCNGJxa3hnVWoreXZmcCtzb2xFeTZk?=
 =?utf-8?B?bGFESEZMTzg0dGxrR2Y5RUM5WTN6OHB2RnozYUNGWnNKZ0FLdGtsNzQ2ZzNG?=
 =?utf-8?B?UXlQTFpwV2xWTXVMTTZnT3d5ZVBUNXpqT3k5Rm12UUwwbW1wbTBDQWZUOGFJ?=
 =?utf-8?B?dGFBbytxVVNPRWlpcFRzWFhHRVBqczNsUTd0ZnZMc2kyZ29iQ2U0SXRTWGt3?=
 =?utf-8?B?ek9YelRXU1NEenZkVEJ1MlQ2UlgyWnhxSWVGSDRxK3ZIdUI5UkpvYXFxVER0?=
 =?utf-8?B?KzZyS2lmc1JTQ0RpL1ZQU0JHVXNKZUUvUy9lcGc5b2krT0IvSWtUazJDYndV?=
 =?utf-8?B?eUJ6U1RRdUNZb1JESlo1US9YVUt3ZndNc0pYS1d3ZjJDcjc4a29nMkorYmRx?=
 =?utf-8?B?c2lVU0l3UEFCSkF2bS9qNjdRSW1XTE56Rno1dk0xNzExVlJUQmxlSXQ4U2hG?=
 =?utf-8?B?SFpkTUdWSHowWDd5MnJkN0pIa3F6amdQcFR2bHhrZGdQamMybDU0cmpMSHBH?=
 =?utf-8?B?SVE5VW5LS0U0Q0E2VlVlOXVacWJxL21MUDZJb1ZEcWFZRWJ3R2NtaGV3TGIx?=
 =?utf-8?B?M0ZDeTFhNEtXYnBzZkNUaTRMQUVvVjIyR2toWDhCSWNETzJYYUtkTzNyenNi?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eU51M0VYSDZ0R0VJcFhjSi90ZmRiSDQrZDdaWmdjeE5vOFI1dWVUS2R3T0xY?=
 =?utf-8?B?WkFIcHdTalVMVHA1R0tDMG9Ec2FkU0tiUnkvR3JFNnZsdldWaENiQVdWNnZT?=
 =?utf-8?B?eXhrVEdWMDVEN3BYUDhvVkp1b1pjRlk2ZU5jcGdBRXJ0MDIwNDU1dThNbmkr?=
 =?utf-8?B?VVRHR0FkSTY1NngwL0pvNTh1Qzh1YUZFWVNROFNISzFnRE4raUFNZy9kVmJr?=
 =?utf-8?B?TzdjclJVTzA0N2lBOThtc0Z2c2NWZkVZTkpWS0lGNko2V3JqeHBrTUlBeHFT?=
 =?utf-8?B?UTVsR1hvZi9ONjJ0Z1ltc20vd3hOQ3g4YldZUWJkRUY4ZnA1UG9RTHBVVUtB?=
 =?utf-8?B?MFdBRENQWVVxU081bmg4cktGQ3Yvb28zU3RKYmQrcmZiMkxzbmNZanlUeW1G?=
 =?utf-8?B?bFFlb1FkOWZzT0ZVM2Q1NlpKb3NIaFZVaEYzMk0ycGlDLzVSZHNOTnJtaDAx?=
 =?utf-8?B?RHFWenZOMzJoTVFEWHVESkJqY1p4eUxxR2x1ZkFWY3lQNmZ1MWZBT2FLY3c3?=
 =?utf-8?B?d1p2RDgrdVBCR0NMcGREeXBGS255Y3RoSWp6eExHUGp2K2hHMDEwY0NqcUxT?=
 =?utf-8?B?Ym1HcWloU3c4VmhzblNZZ3hxUi85ZmJNNFlvUktObCtJQmdpd1U0aDBwUGU3?=
 =?utf-8?B?RUhFU0hCSHgrUDdpcVJ5K0Q2SVVPWXMySFNKa2pxQ3RkNkJGb0lFc1YxRG91?=
 =?utf-8?B?VWowWVRuZXVEd0xNZDFjZHNwYjc2azBtVHJsQ1JqODVqaHZWQUNsWHR6NmVr?=
 =?utf-8?B?L1ZOOE9GRlgwdzVqeVJMQmt0VlBYVjd3NlU5ZTlpSFF6ZG9ybk9zbHZDU3dO?=
 =?utf-8?B?L0lDMi9kTFVTZHJ5emtkall6WU9uQlZsaVBTQ2ZrQlNGbUR6VTlwMENVc1RX?=
 =?utf-8?B?czllRWN6eERnMmZkWEM1ZXJqZThnallFeXBFREU4QXpickcxenErTXRpbDdz?=
 =?utf-8?B?U0J6YTZFTktSU3FHRDBZcUZIQjdJV3lDN3ZzY01yakJlQjJxQXh6TVNJU3F0?=
 =?utf-8?B?NExmRmhSTGpnZkdEWWFCZG1wbWtWVFQ5MTk1eGFZWXJzWmVzK1pSUHJzTkhu?=
 =?utf-8?B?anBCaVJ5NXV1aGxDcTFCVVgxck0xQzFDQXBvMmJsNDZxM1FYQ3V6cGpxSDZ3?=
 =?utf-8?B?QTcrcFlHdkIxcHpFWVRmVTMzZVFHbTU3b2tORWg0eWpIWndaT29qOWxIOHlF?=
 =?utf-8?B?OHN4WU1FdTVQbmpSNlRVVkpnUzFVbnVpb2JTZkwvMVZvWVR4VERDMWxGaTJJ?=
 =?utf-8?B?MnpCTnh6QW52QkwzelZucSt1ZS92TVdUK0VaQUIvbEJkTy82dENIK3JNUFAy?=
 =?utf-8?B?UUVHbXY3NjllNk9XWlhDVUtUQzN3WU41eElDUzlTVENTeU5Md2lDOVBPYmNX?=
 =?utf-8?B?MkdheDk3c2xNbFlkK2tiY050M2ZVZ0xzazVudmxrVFg5aHY4UVFhSnoybXNP?=
 =?utf-8?B?S3ArMEFrS1VyQVRiNGZHakpSWEpvL3gwZXF4TjlZcm54SldCTHhpYkdzeDYz?=
 =?utf-8?Q?tdzvdA=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda26bdb-f20a-4ea9-b118-08db25624103
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6368.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 14:33:33.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6wFZglq4zZuUHKDsUONYhVyH/qz+zLKENV2hu25mXwHdy8bsZqIZJJzL5LWV5JFkMPzeO4oqSe8OAfDqNB0fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5644
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:38:18PM +0100, Juergen Gross wrote:
> On 15.03.23 13:10, Roger Pau Monne wrote:
> > In ACPI systems, the OS can direct power management, as opposed to the
> > firmware.  This OS-directed Power Management is called OSPM.  Part of
> > telling the firmware that the OS going to direct power management is
> > making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> > methods must be evaluated for every processor object.  If these _PDC
> > calls are not completed for every processor it can lead to
> > inconsistency and later failures in things like the CPU frequency
> > driver.
> > 
> > In a Xen system, the dom0 kernel is responsible for system-wide power
> > management.  The dom0 kernel is in charge of OSPM.  However, the
> > number of CPUs available to dom0 can be different than the number of
> > CPUs physically present on the system.
> > 
> > This leads to a problem: the dom0 kernel needs to evaluate _PDC for
> > all the processors, but it can't always see them.
> > 
> > In dom0 kernels, ignore the existing ACPI method for determining if a
> > processor is physically present because it might not be accurate.
> > Instead, ask the hypervisor for this information.
> > 
> > Fix this by introducing a custom function to use when running as Xen
> > dom0 in order to check whether a processor object matches a CPU that's
> > online.
> > 
> > This ensures that _PDC method gets evaluated for all physically online
> > CPUs, regardless of the number of CPUs made available to dom0.
> > 
> > Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Changes since v1:
> >   - Reword commit message.
> > ---
> >   arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
> >   arch/x86/xen/enlighten.c              | 27 +++++++++++++++++++++++++++
> >   drivers/acpi/processor_pdc.c          | 11 +++++++++++
> >   3 files changed, 48 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> > index 5fc35f889cd1..f14e39bce2cb 100644
> > --- a/arch/x86/include/asm/xen/hypervisor.h
> > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
> >   void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> >   #endif
> > +#ifdef CONFIG_XEN_DOM0
> > +bool __init xen_processor_present(uint32_t acpi_id);
> > +#else
> > +static inline bool xen_processor_present(uint32_t acpi_id)
> > +{
> > +	BUG();
> > +	return false;
> > +}
> > +#endif
> > +
> >   #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > index b8db2148c07d..d4c44361a26c 100644
> > --- a/arch/x86/xen/enlighten.c
> > +++ b/arch/x86/xen/enlighten.c
> > @@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
> >   }
> >   EXPORT_SYMBOL(xen_arch_unregister_cpu);
> >   #endif
> > +
> > +#ifdef CONFIG_XEN_DOM0
> > +bool __init xen_processor_present(uint32_t acpi_id)
> > +{
> > +	unsigned int i, maxid;
> > +	struct xen_platform_op op = {
> > +		.cmd = XENPF_get_cpuinfo,
> > +		.interface_version = XENPF_INTERFACE_VERSION,
> > +	};
> > +	int ret = HYPERVISOR_platform_op(&op);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	maxid = op.u.pcpu_info.max_present;
> > +	for (i = 0; i <= maxid; i++) {
> > +		op.u.pcpu_info.xen_cpuid = i;
> > +		ret = HYPERVISOR_platform_op(&op);
> > +		if (ret)
> > +			continue;
> > +		if (op.u.pcpu_info.acpi_id == acpi_id)
> > +			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
> > +	}
> > +
> > +	return false;
> > +}
> > +#endif
> 
> Did you consider not to do the hypercall again and again, but to reuse the
> pcpu list from drivers/xen/pcpu.c instead? You'd need to store the acpi_id
> in this list, of course.

Oh, didn't know this was available.  Seems to be initialized before
the _PDC evaluation, so I can give it a try.

Thanks, Roger.
