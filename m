Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776263C55F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbiK2QmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiK2QmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:42:03 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D360EB3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669740121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Cz7h3YCNxkChMOYTsxVSzgklzua5NsObeP1HZOBZzQQ=;
  b=GLttpV3ap+odeUG3k4+FnVHCsYCkIGWz6bUZYU59GQNPL1goUm+t2Gfx
   6eG9drqjdFk68T/G93n0y+bYG3yTHetWOTJWDPT1YMQ9OcPOemuVCeuny
   6c0JpTByaBEiAxAHmD9eEt6NYNWohd2X+Cxz3u3e9mSOhTSkAEZQ8GRyh
   0=;
X-IronPort-RemoteIP: 104.47.59.177
X-IronPort-MID: 86205258
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:nGwdZ6jjXfoY2ZGgrqvdrN1VX161+BEKZh0ujC45NGQN5FlHY01je
 htvXD/SbvyCazGnf9ElPdu2oENTvpLUzdZgGVQ+rH0xFigb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmUpH1QMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWs0N8klgZmP6oS5QWPzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQYDmggazKN1tuJ+6KVF9RK3Z8PCdDCadZ3VnFIlVk1DN4AaLWaGeDmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEgluGyb7I5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6ROPirqMw3Q37Kmo7GkUOCmTh++CCkRSVWNNEB
 3Q6/nMAlP1nnKCsZpynN/Gim1aGsQQbQMF4CPAh5UeGza+8ywKYAHUUCz1MctorsOcoSjEwk
 FyEhdXkAXpoqrL9YWmG6r6eoDe2OC4UBWwPfykJSU0C+daLiIY3gxHUR9BvCpmpn8b1EjH9x
 TONhCUmjrBVhskOv42x+krGmHSrvYTTSRAu5RT/WXis5Qd0IoWiYuSA61LW8PJBJ4axVUSas
 T4PnM32xPADC9SBmTKARM0JHaq1/LCVPTvEm1ltEpI9sTO39BaekZt45Th/IAJlN5gCcDqwO
 kvL41oOu9lUIWegarJxb8SpEcM2wKP8FNPjEPfJct5JZZs3fwiClM1zWXOtM6nWuBBEuckC1
 V2zK65A0V5y5Xxb8QeL
IronPort-HdrOrdr: A9a23:kCsogqyDf6H3RFjKfegQKrPxv+skLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9IYgBZpTnyAtj6fZq8z+893WB1B9uftWbdyQ+Vxe1ZjLcKhgeQYhEWldQtnZ
 uIEZIOb+EYZGIS5amV3OD7KadH/DDtytHKuQ6q9QYJcegcUdAD0+4WMGamO3wzYDMDKYsyFZ
 Ka6MYCjSGnY24rYsOyAWRAd/TfpvXQ/aiWKyIuNloC0k2jnDmo4Ln1H1yzxREFSQ5Cxr8k7C
 zsjxH53KO+qPu2oyWsmlM7rq4m1OcJ+OEzSvBkufJlawkETTzYJLiJbofy8wzdZtvfq2rC3u
 O84SvIdP4DkU85NlvF3CcFnTOQmwrGokWStWOwkD/tp9f0Syk9DNcEjYVFcgHB405lp91k1r
 lXtljpw6a/ICmw7hgV3eK4Ii1Chw6xuz4vgOQTh3tQXc8Xb6JQt5UW+AdQHI0bFCz35Yg7GK
 02Zfusksp+YBefdTTUr2NvyNujUjA6GQqHWFELvoiQ3yJNlH50wkMEzIgUn2sG9pg6V55Yjt
 60RZhAhfVLVIsbfKh9DOAOTY++DXHMWwvFNCaILVHuBMg8SgHwQl7MkcUIDc2RCe01JcEJ6e
 v8uXtjxBAPR34=
X-IronPort-AV: E=Sophos;i="5.96,203,1665460800"; 
   d="scan'208";a="86205258"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 11:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9S37xHtMm9JjfHWQRpn3RjWJC4nv5azbGvFEdJaGVW5dXa6bRBIU0AqsUWC+vRICFwDGvF8npQfFvieHd940Vs4wZYp3MSTRY8V+9DufQQ/Jl9VrwVgAPFu8irYEJ+mGHGqYguLuSLTSr97l5mj/MDoanTUdLhiU2Nk49ysIPLQuR5B7bsaQdmkCN5RwsJE2ryi+9QyEuWFhRshNsovfjcUBi2yOUMZL/KPtSVA6GzUP5T5FAwVktSLDpUKPXLSFZcxPicfIwfICrHRNR9OJZg+kOI3osIuNjlAHeYvoSyW2s13FFDoR2dnNVu14SztX50wu3523Bb8CmSa78Pwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz7h3YCNxkChMOYTsxVSzgklzua5NsObeP1HZOBZzQQ=;
 b=L3t04PbIY0K2teTf13lUzspbzyfpqKgpYqMGgyK+fHPmLiYGyyuC0n+DVQEoVKRho5TGfvvz3/NCCxp6mvN3dovC4tpNnxvgnwNDvqz/JPWaA7BTF3/CkzP5ooZAyiTl5tAE1jsjkjkcDAD/fSgb/RU37I5J3uxogzocwR3LLA92X8ln5M/4lnTmmflIAGlxRK+4fJQaYb2Ju102dWpd2v+4nUFpgHwAZuYSBrthFJDwy0zwYK9LgjJ9XCmwiwiQb+uD6Qo5OHfbSvAI5k5QMQwR4KdCyUdCpje09rp9aRaY35VRDbFDkoO0LE4XBymqZwfEqAtkEytiR+EGWIOkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz7h3YCNxkChMOYTsxVSzgklzua5NsObeP1HZOBZzQQ=;
 b=qqEJjL02vEIN4tS8PELKk4v/T3YFkTBD//8ryneBg8WdIPwbaBjFq3f8e3v6otfevpG6b4CVHo8oJSpiaKIk2Ss1GrTlo7X+K3w5iFuvid13WXYdAa6coL0MNakMEhRlMjJncU5R7zOoUG9P91nBexsi7XpHAy5NgD6Qt4NdIpk=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB6802.namprd03.prod.outlook.com (2603:10b6:510:119::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:41:56 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:41:56 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Juergen Gross <jgross@suse.com>,
        "Per Bilse (3P)" <Per.Bilse@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Topic: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
Thread-Index: AQHZBAVaARHwkOAmUU2q2Cs+/8XQvK5WBiMAgAAUzgA=
Date:   Tue, 29 Nov 2022 16:41:56 +0000
Message-ID: <92300a81-b97b-f5d6-e3e8-363d8a7d3742@citrix.com>
References: <20221129150058.266943-1-per.bilse@citrix.com>
 <358e49fa-8ce7-67ce-8e0b-e523dee9ea19@suse.com>
In-Reply-To: <358e49fa-8ce7-67ce-8e0b-e523dee9ea19@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|PH0PR03MB6802:EE_
x-ms-office365-filtering-correlation-id: a0dd2379-d9a8-488b-df98-08dad228a0ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 550GLMgem7tmBJJoS7PSwqg0P2UEzD1jq9rPcRTz3TpHabzB7LxoplfVkmdMoDxYcCYLjTPrN5N6bdW+yvlaq/d4GoarzVULgsP+CYtTebybp/Ts9IJ1whbSecDiKk/CI3jGlF/BiiZ2tLdb1d9xn9WoS+clTpBeY6Xvog3x10BAgQFOfU7a2KJsfD90xecJD2W6SG9YQ4fC4f/rctDVOjbKz1NPoFxnAyfXnowJpmkDEj8Hdc/4/SVyD1cINemAU6Ifyi5FcvWl27MaKSPKNKe/rr9PzxCLd6Yb+AImm8+9QHN6D3Mvyz3ZECTF8m1TpfQ4DsnUT/CELKLaP0Q2w4f7SoD0QCHJ1998eazm8TKaCct323FxJl83dKRm+5HiA2bfuTwgQG60ILKACSMnispH4ftbwwDIsgVH7pyMZXKM7fVkp5XsEzKYpAeq5h96dqcZ1TbQzntXzLAvYtv9EeIS+BXr+adQhpuyzQTLyKUlaxckSNU/nHzr08LDsS1LWo+lG+PM/PAKlJqHlLJqERmQ5iV13iuuzaKOnnfmvoyAQ4eUnTclyoOg/+MjY36/iyDvfWwvIFMyAS74Niuz8qVoM0ObKukSPQ7PdT37vEO9yLWeSkOe+BhZi6dHpQtcK1gBRjpw+dH6gNVPnrZEzKBJLOpmmphIlNvMz7W5Z988JQxQbNvJcatJW8aMZnObXiCV6UEyV//46YdzbFBS4QNR0bvSTPG/0Yo8oXUFtYmEUsTo/uLekX0QngD4K9nwSHUXyQSoTHsdT/9JtcDezw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(5660300002)(38070700005)(110136005)(54906003)(8936002)(316002)(6512007)(41300700001)(2616005)(186003)(76116006)(66946007)(66556008)(4326008)(122000001)(64756008)(36756003)(8676002)(91956017)(66476007)(66446008)(38100700002)(2906002)(82960400001)(26005)(86362001)(83380400001)(6506007)(71200400001)(478600001)(31696002)(6486002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RERrL1BuS2R0YWpxNW8xR292c0VvUGtvVkdLMHc3dWJsREJWTXl2eDA1aUNL?=
 =?utf-8?B?b0FRWlJjRTQxZWpJRUNmU1laSzhxRjd0ajZvZldETWZHVFVia2ZrWUl1RmdV?=
 =?utf-8?B?N3l6cEYyampOQ3NIdjlOQTlGV0lCNE1nQk1YSldLV1BpWGhUbWswVVcvMngv?=
 =?utf-8?B?RG4vQlE0TGhyVkZKd1ZIQ2Y0SEtKNHlGL3R1aUZYWDUwTkRlQ2dxVGN0V0hh?=
 =?utf-8?B?S05qZWlsRTlWY0FYMkloYU9PNnoxRHh4OENhUFVzcStRTFZRNU5IWUNySERW?=
 =?utf-8?B?eCt5NFNWWTdlTHlJczRUSGZOYWNpZ3BqTENzOCtaOFNRRWJWTTRqamphZXBR?=
 =?utf-8?B?UlM0VmQreU85Rld6akdSNktrMG9hVEMzb2V0ZlBKNlBOa24zZzNsVEJNa0da?=
 =?utf-8?B?bTUrQUVDU3o4SHVKNE5nMnpZcUthZG1TTnpqZytxdjNzV0RXbVhvcnJaNVpW?=
 =?utf-8?B?SEJQOXdTWWw5cTVDeHJnODZlWlVCODVtTjZMQWRTZ3BzY0ZVM0tWeklCVitK?=
 =?utf-8?B?VmxiMEUwV1U5T2VzK3p3TUE4ZG5xL0NzSks5Y1p2SzAvNG9HSVpKQWJiTEdY?=
 =?utf-8?B?THAwdjNibjJNdXpCS1V0aUkyaEhRWGpsUDVxTWowdzgzZXdkN0xDTHNrb0FR?=
 =?utf-8?B?blFTTEFNSFlLSXhOM0FYTTZEc3kzSmplamNJMDU4a09uNE1oNWg5ZVd4QWl4?=
 =?utf-8?B?ODk2dFVPK2g0bExsQ2VPdW5vQ3pBOU9Qa2NWNzZiVXJBd3JLa0cvWDNKYkVv?=
 =?utf-8?B?Tm15bmlPNEZLWU5RKzlhWS8rb05XU3cxazA5cm5MWW9KRjUrbGIwWWZ3bWg5?=
 =?utf-8?B?UXVIMXVCU2hSVEN5ZkZqaE9FQk1hcExXYU9nMjdGWEtWWFVMa0dQWEF0dGhD?=
 =?utf-8?B?WE0wR2IxeEFpWHZBbmFmWE03bGhLSlBXZkFFNjVEeTk0bHFodHJBMElseGFh?=
 =?utf-8?B?TXJ1RE9YYUtqeXptTmg5T3k3eVFZeHNGejQrQ0lTa09PY3pZNEE4VWdsRS93?=
 =?utf-8?B?b1FVekdXOUJpdHgvNkw0OFlZNjdYTFpzZllZOEkzTWh0dURSdnZhdk1WYnQ4?=
 =?utf-8?B?NmZBQm1GeWlvOW9OeHg5bnhsM05zTWdXVGsrZ0ZqUm4zTVByNVg1eElhZmta?=
 =?utf-8?B?L1RYN2VqQXZSTGRVcktmUDJLNG5IdjdCRDdSSzRDWFA3eDRJQXVob0tYQnk3?=
 =?utf-8?B?TGRsSmdwdm1KRFIxb1NwWDJaT0JrbXBJakM0emc2R0FrcCtWUEt5SklwZnpn?=
 =?utf-8?B?RllvQWhSZ2pPSVo1aExETlVqeFVKSHBnRnFncWdZWi9va2M0cUJoNnFXMXpv?=
 =?utf-8?B?d3E2Z2FaMDRJMCs4NTlmS2gxekdnYWpRMlQ5OXZxYWdxZC9mNWpHdVJrT1Jj?=
 =?utf-8?B?SFBQRjhqckZ2bm1IbytWbE9GOERHaEtRMzRvTnFHVEROYTdWTGVjdVBSM0hV?=
 =?utf-8?B?Y285WG5Wc3ZUZm1NVjdvaURpZ1JFNGE5UWdDRFpZVmdoNGF4bmxYSVlnT0VB?=
 =?utf-8?B?Y1ZFMEFIbEEySEh3UDdJdW00R3FPa1htMFVFS3kydTRnaFpYcmVqeXV2MVkz?=
 =?utf-8?B?dG1jQnEwb0Q5OGxhTzZQUDlEdjhMRlJYVEgzVmJSMXZrVW5DUk5qVjk4dUFs?=
 =?utf-8?B?TGJiRDVBeFgrNnRlUy9mSXVPWERyL3JtMkQ2cU4wemZoL2NBSzhZR1FzY3dq?=
 =?utf-8?B?TXpFT3FJWWxZVG9oWnc0cm9zZkRQRmFNWFZHUzgvS2V1NEFHZjhvazBrZ0M3?=
 =?utf-8?B?a1dtZURlaWhWTHg3L3JTT1c4T2dVM1A2akx4T0V0QU8rUnFxR09rbk1sclpK?=
 =?utf-8?B?UDZoZTF1UjlkQ2JpVE5qOWU4ZW85di9DbEViMWZHbEtKNGFtTTBUTjNhWE1D?=
 =?utf-8?B?d3FQUGNrMHFNdGJjK1F5elRpNkdoR0xPQU5GY2hVNG84MDJCQWJhWWhHZmhq?=
 =?utf-8?B?ZkphWHp6R2p4RVpZOXBsRkdjUEk4ZkVuYkhnWXNiVFNmajJZVWJ4QXR6dGY3?=
 =?utf-8?B?WDcySGU4My9qSzNiS2NwekovTWpzK0hFK1NXU3poWEdnMXRJbmQxVUNLa1JJ?=
 =?utf-8?B?SlhIeUlvL3RwZTBiSG1WbXhhc2lRL0FqTVVlbHQ5ZXhLNnpRZGVjdDBMV0RH?=
 =?utf-8?Q?lWYXhIgi5HgYB/6h0QZlZUQe6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99168C812DDDB5448540D3B382343237@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VGUzNzhGMlZzUWRxcmM3elAvai9abVMxYkF3TGk2RFJRa1VCRzdNcXZOVVBX?=
 =?utf-8?B?YWs0L0dYS0VCc0lVNGtPYUxqTGZDN1BFTGVQb1RRR0xOMkJNa0lsTEpKdnFj?=
 =?utf-8?B?ZEtWdnZ2am9JaVhwT2xWNkRBeXV0RjlFWmhSVG8rcE9Ic05XZ2VoSkNXYU90?=
 =?utf-8?B?V2c4OWdEWkg3em9ZUDd6STJVVzFRYXkzNDlNQk5UTkpXdUxpMU5oWjlzYng2?=
 =?utf-8?B?UE8rY3ZpR2FUL2ZCMnAvcHFRRUtpVnhEN3grc3BZc1VMM1d5Uk16aW8rdUpr?=
 =?utf-8?B?SDhkYStya0ZGYnZsOTQ3a0piZ3c0Z2tpSTRJaXZ1aytTbTBHcUlUMlk5T2Fu?=
 =?utf-8?B?QVQveXFSdjI2WGVNSnAyVlo3OXFxZlVEY3p2RHpuM3A1N0prUzEvakRYNTNh?=
 =?utf-8?B?ME11MzM1WXM2di9KQ0w4ZGl5NWEvKyszOGhzTHRCL2NGTVdRcHN0b243R0li?=
 =?utf-8?B?WFNvMVFOMERLNkRUVWNobFhVWmxpOFlnb29MeXBhNHBSRDBsMGUzRnZpV2Yx?=
 =?utf-8?B?V2tVbERBL2c5T2hQZEU3bThFd1RhdTNudWVhYWJlb0JGRXZsOTJqNXNxanhy?=
 =?utf-8?B?Mi9IUVlMamtsSmZKRzVoYXBGbVBOY2c3aFBqN3g3bXFWNDRqRlhQWEN6ZE00?=
 =?utf-8?B?YWpaYWpEM042NjRLT2UxWVI5WTlnbzVlbnhJS09uV1NhZEpETiswTTFpUUtK?=
 =?utf-8?B?MmozY21MTy9aWGFhbUhjVFRzbzk3dWdXT3RsT2t5MTJYT3BLV3BZZm5NbCtY?=
 =?utf-8?B?a2xGRk9Vc1pCYzlqcTM3ZjBMR3lxQ2ZwMWVWR29HQTR4aDlWUUozeWlUUjBk?=
 =?utf-8?B?TGJETEZLTnRnOUVTeTZXZmxaU0RyNHJrNlcvRUxKcUlKaEdmTVNYajRZK1kz?=
 =?utf-8?B?QlRyb1V1TGs5QWZUOG5rZHJoWnlJUTFQWit4QnZrT2tGbk1QMTNNL0EzU09N?=
 =?utf-8?B?cnFEaVlvNC8wWE5rQkJ5ZU1JRmxBU0NjalBHejF2dHg1a2FUWmRsclI0RzYv?=
 =?utf-8?B?MFJNbXBTZ1hycmIrcWtLMjA5UFJCRkcrY0RRM0ozMHl5Y1BEcjRVcjdXV1FU?=
 =?utf-8?B?SHZTYmtRdnltLzUyS2JWd2hNd282S2FPZ3dDNFJYRytGb3lkeE9OVmRBcThp?=
 =?utf-8?B?ZHRPSkFvcDZrbTN4RVkyUHU0dDdBdHNmTHJ0RzJQNytsWnF5dlJwbFp5bFhk?=
 =?utf-8?B?cGtqU0F3akxSejl0am1QS0FwbDh6TTRFZmhEMS9PWHk1OEw0V0pUSmJDdGli?=
 =?utf-8?B?ZFY3RUZpN2NzcjJud05yaCsyTjYxUzE2R2NzY3ZOTytoQm5SZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dd2379-d9a8-488b-df98-08dad228a0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:41:56.6306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AselWAORgMynvfH2GmgSrcfO7QWM9y6zbct8EpzfDZvgSVf34Llk5sH2qCRb3ijfVZUsy2bJ6SZSLeMMYOckYs19ZlDvzns8qmGG/i5iK24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6802
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMTEvMjAyMiAxNToyNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gT24gMjkuMTEuMjIg
MTY6MDAsIFBlciBCaWxzZSB3cm90ZToNCj4+IC9wcm9jL3hlbiBpcyBhIGxlZ2FjeSBwc2V1ZG8g
ZmlsZXN5c3RlbSB3aGljaCBwcmVkYXRlcyBYZW4gc3VwcG9ydA0KPj4gZ2V0dGluZyBtZXJnZWQg
aW50byBMaW51eC7CoCBJdCBoYXMgbGFyZ2VseSBiZWVuIHJlcGxhY2VkIHdpdGggbW9yZQ0KPj4g
bm9ybWFsIGxvY2F0aW9ucyBmb3IgZGF0YSAoL3N5cy9oeXBlcnZpc29yLyBmb3IgaW5mbywgL2Rl
di94ZW4vIGZvcg0KPj4gdXNlciBkZXZpY2VzKS7CoCBXZSB3YW50IHRvIGNvbXBpbGUgeGVuZnMg
c3VwcG9ydCBvdXQgb2YgdGhlIGRvbTAga2VybmVsLg0KPj4NCj4+IFRoZXJlIGlzIG9uZSBpdGVt
IHdoaWNoIG9ubHkgZXhpc3RzIGluIC9wcm9jL3hlbiwgbmFtZWx5DQo+PiAvcHJvYy94ZW4vY2Fw
YWJpbGl0aWVzIHdpdGggImNvbnRyb2xfZCIgYmVpbmcgdGhlIHNpZ25hbCBvZiAieW91J3JlIGlu
DQo+PiB0aGUgY29udHJvbCBkb21haW4iLsKgIFRoaXMgdWx0aW1hdGVseSBjb21lcyBmcm9tIHRo
ZSBTSUYgZmxhZ3MgcHJvdmlkZWQNCj4+IGF0IFZNIHN0YXJ0Lg0KPj4NCj4+IFRoaXMgcGF0Y2gg
ZXhwb3NlcyBhbGwgU0lGIGZsYWdzIGluIC9zeXMvaHlwZXJ2aXNvci9wcm9wZXJ0aWVzL2ZsYWdz
LA0KPj4gd2hpY2ggd2lsbCBjb2V4aXN0IHdpdGggL3Byb2MveGVuIHdoaWxlIGRlcGVuZGVuY2ll
cyBhcmUgYmVpbmcgbWlncmF0ZWQuDQo+PiBQb3NzaWJsZSB2YWx1ZXMgYXJlICJwcml2aWxlZ2Vk
IiwgImluaXRkb21haW4iLCAibXVsdGlib290IiwNCj4+ICJtb2Rfc3RhcnRfcGZuIiwgYW5kICJ2
aXJ0bWFwIiwgd2l0aCAiaW5pdGRvbWFpbiIgYmVpbmcgdGhlIGVxdWl2YWxlbnQNCj4+IG9mICJj
b250cm9sX2QiLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBlciBCaWxzZSA8cGVyLmJpbHNlQGNp
dHJpeC5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29yLmMgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAgaW5jbHVkZS94ZW4vaW50ZXJmYWNl
L3hlbi5owqAgfCAxMyArKysrKysrKy0tLS0tDQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDM0IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
eGVuL3N5cy1oeXBlcnZpc29yLmMgYi9kcml2ZXJzL3hlbi9zeXMtaHlwZXJ2aXNvci5jDQo+PiBp
bmRleCBmY2IwNzkyZjA5MGUuLjczOTNlMDRiZGI2ZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
eGVuL3N5cy1oeXBlcnZpc29yLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3N5cy1oeXBlcnZpc29y
LmMNCj4+IEBAIC0zNzksNiArMzc5LDMxIEBAIHN0YXRpYyBzc2l6ZV90IGJ1aWxkaWRfc2hvdyhz
dHJ1Y3QNCj4+IGh5cF9zeXNmc19hdHRyICphdHRyLCBjaGFyICpidWZmZXIpDQo+PiDCoCDCoCBI
WVBFUlZJU09SX0FUVFJfUk8oYnVpbGRpZCk7DQo+PiDCoCArc3RhdGljIHNzaXplX3QgZmxhZ3Nf
c2hvdyhzdHJ1Y3QgaHlwX3N5c2ZzX2F0dHIgKmF0dHIsIGNoYXIgKmJ1ZmZlcikNCj4+ICt7DQo+
PiArwqDCoMKgIHN0YXRpYyBjaGFyIGNvbnN0ICpjb25zdCBzaWZzdHJbU0lGTl9OVU1fU0lGTl0g
PSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgW1NJRk5fUFJJVl3CoCA9ICJwcml2aWxlZ2VkIiwNCj4+
ICvCoMKgwqDCoMKgwqDCoCBbU0lGTl9JTklUXcKgID0gImluaXRkb21haW4iLA0KPj4gK8KgwqDC
oMKgwqDCoMKgIFtTSUZOX01VTFRJXSA9ICJtdWx0aWJvb3QiLA0KPj4gK8KgwqDCoMKgwqDCoMKg
IFtTSUZOX1BGTl3CoMKgID0gIm1vZF9zdGFydF9wZm4iLA0KPj4gK8KgwqDCoMKgwqDCoMKgIFtT
SUZOX1ZJUlRdwqAgPSAidmlydG1hcCINCj4+ICvCoMKgwqAgfTsNCj4+ICvCoMKgwqAgdW5zaWdu
ZWQgc2lmbnVtLCBzaWZtYXNrOw0KPj4gK8KgwqDCoCBzc2l6ZV90IHJldCA9IDA7DQo+PiArDQo+
PiArwqDCoMKgIHNpZm1hc2sgPSB+KH4wVSA8PCBTSUZOX05VTV9TSUZOKTvCoCAvLyAuLi4wMDAw
MTExLi4uDQo+PiArwqDCoMKgIGlmICh4ZW5fZG9tYWluKCkgJiYgKHhlbl9zdGFydF9mbGFncyAm
IHNpZm1hc2spICE9IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKHNpZm51bSA9IDA7IHNp
Zm51bSAhPSBTSUZOX05VTV9TSUZOOyBzaWZudW0rKykgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKCh4ZW5fc3RhcnRfZmxhZ3MgJiAoMTw8c2lmbnVtKSkgIT0gMCkNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ICs9IHNwcmludGYoYnVmZmVyK3JldCwgIiVz
ICIsIHNpZnN0cltzaWZudW1dKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+PiArwqDCoMKgwqDC
oMKgwqAgYnVmZmVyW3JldC0xXSA9ICdcbic7DQo+PiArwqDCoMKgIH0NCj4+ICvCoMKgwqAgcmV0
dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiArSFlQRVJWSVNPUl9BVFRSX1JPKGZsYWdzKTsNCj4+
ICsNCj4+IMKgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICp4ZW5fcHJvcGVydGllc19hdHRyc1td
ID0gew0KPj4gwqDCoMKgwqDCoCAmY2FwYWJpbGl0aWVzX2F0dHIuYXR0ciwNCj4+IMKgwqDCoMKg
wqAgJmNoYW5nZXNldF9hdHRyLmF0dHIsDQo+PiBAQCAtMzg2LDYgKzQxMSw3IEBAIHN0YXRpYyBz
dHJ1Y3QgYXR0cmlidXRlICp4ZW5fcHJvcGVydGllc19hdHRyc1tdID0gew0KPj4gwqDCoMKgwqDC
oCAmcGFnZXNpemVfYXR0ci5hdHRyLA0KPj4gwqDCoMKgwqDCoCAmZmVhdHVyZXNfYXR0ci5hdHRy
LA0KPj4gwqDCoMKgwqDCoCAmYnVpbGRpZF9hdHRyLmF0dHIsDQo+PiArwqDCoMKgICZmbGFnc19h
dHRyLmF0dHIsDQo+PiDCoMKgwqDCoMKgIE5VTEwNCj4+IMKgIH07DQo+PiDCoCBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3hlbi5oIGIvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3hl
bi5oDQo+PiBpbmRleCAwY2EyM2VjYTJhOWMuLjc2MmEzNDhhYmUzZSAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUveGVuL2ludGVyZmFjZS94ZW4uaA0KPj4gKysrIGIvaW5jbHVkZS94ZW4vaW50ZXJm
YWNlL3hlbi5oDQo+PiBAQCAtNjQ4LDExICs2NDgsMTQgQEAgc3RydWN0IHN0YXJ0X2luZm8gew0K
Pj4gwqAgfTsNCj4+IMKgIMKgIC8qIFRoZXNlIGZsYWdzIGFyZSBwYXNzZWQgaW4gdGhlICdmbGFn
cycgZmllbGQgb2Ygc3RhcnRfaW5mb190LiAqLw0KPj4gLSNkZWZpbmUgU0lGX1BSSVZJTEVHRUTC
oMKgwqDCoMKgICgxPDwwKcKgIC8qIElzIHRoZSBkb21haW4gcHJpdmlsZWdlZD8gKi8NCj4+IC0j
ZGVmaW5lIFNJRl9JTklURE9NQUlOwqDCoMKgwqDCoCAoMTw8MSnCoCAvKiBJcyB0aGlzIHRoZSBp
bml0aWFsIGNvbnRyb2wNCj4+IGRvbWFpbj8gKi8NCj4+IC0jZGVmaW5lIFNJRl9NVUxUSUJPT1Rf
TU9EwqDCoCAoMTw8MinCoCAvKiBJcyBtb2Rfc3RhcnQgYSBtdWx0aWJvb3QNCj4+IG1vZHVsZT8g
Ki8NCj4+IC0jZGVmaW5lIFNJRl9NT0RfU1RBUlRfUEZOwqDCoCAoMTw8MynCoCAvKiBJcyBtb2Rf
c3RhcnQgYSBQRk4/ICovDQo+PiAtI2RlZmluZSBTSUZfVklSVF9QMk1fNFRPT0xTICgxPDw0KcKg
IC8qIERvIFhlbiB0b29scyB1bmRlcnN0YW5kIGENCj4+IHZpcnQuIG1hcHBlZCAqLw0KPj4gKy8q
IFRleHQgc3RyaW5ncyBhcmUgcHJpbnRlZCBvdXQgaW4gc3lzLWh5cGVydmlzb3IuYywgd2UgZ3Vh
cmTCoMKgICovDQo+PiArLyogYWdhaW5zdCBtaXgtdXBzIGFuZCBlcnJvcnMgYnkgZW51bWVyYXRp
bmcgdGhlIGZsYWdzLsKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+ICtlbnVtIHsgU0lGTl9QUklWLCBT
SUZOX0lOSVQsIFNJRk5fTVVMVEksIFNJRk5fUEZOLCBTSUZOX1ZJUlQsDQo+PiBTSUZOX05VTV9T
SUZOIH07DQo+PiArI2RlZmluZSBTSUZfUFJJVklMRUdFRMKgwqDCoMKgwqAgKDE8PFNJRk5fUFJJ
VinCoCAvKiBJcyB0aGUgZG9tYWluDQo+PiBwcml2aWxlZ2VkPyAqLw0KPj4gKyNkZWZpbmUgU0lG
X0lOSVRET01BSU7CoMKgwqDCoMKgICgxPDxTSUZOX0lOSVQpwqAgLyogSXMgdGhpcyB0aGUgaW5p
dGlhbA0KPj4gY29udHJvbCBkb21haW4/ICovDQo+PiArI2RlZmluZSBTSUZfTVVMVElCT09UX01P
RMKgwqAgKDE8PFNJRk5fTVVMVEkpIC8qIElzIG1vZF9zdGFydCBhDQo+PiBtdWx0aWJvb3QgbW9k
dWxlPyAqLw0KPj4gKyNkZWZpbmUgU0lGX01PRF9TVEFSVF9QRk7CoMKgICgxPDxTSUZOX1BGTinC
oMKgIC8qIElzIG1vZF9zdGFydCBhIFBGTj8gKi8NCj4+ICsjZGVmaW5lIFNJRl9WSVJUX1AyTV80
VE9PTFMgKDE8PFNJRk5fVklSVCnCoCAvKiBEbyBYZW4gdG9vbHMNCj4+IHVuZGVyc3RhbmQgYSB2
aXJ0LiBtYXBwZWQgKi8NCj4NCj4gUGxlYXNlIGRvbid0IGNoYW5nZSB0aGlzIGhlYWRlciwgYXMg
aXQgaXMgYmFzZWQgb24gaXRzIG1hc3Rlcg0KPiBsb2NhdGVkIGluIHRoZSBYZW4gcmVwb3NpdG9y
eS4NCj4NCj4gQW4gYWNjZXB0YWJsZSBzb2x1dGlvbiB3b3VsZCBiZSB0byBzZW5kIGEgWGVuIHBh
dGNoIGZpcnN0IGRvaW5nIHRoZQ0KPiB4ZW4uaCBjaGFuZ2VzLCBhbmQgd2hlbiB0aGF0IHBhdGNo
IGhhcyBiZWVuIHRha2VuIHRvIG1vZGlmeSB0aGUNCj4gcmVsYXRlZCBMaW51eCBoZWFkZXIgYWNj
b3JkaW5nbHkuDQo+DQo+IEluIGNhc2UgeW91IHdhbnQgdG8gZ28gdGhhdCByb3V0ZSwgcGxlYXNl
IGFkZCBhICJYRU5fIiBwcmVmaXggdG8gdGhlDQo+IGVudW0gbWVtYmVycy4NCg0KWW91IGNhbid0
IHVzZSBlbnVtcyBpbiB0aGUgcHVibGljIGhlYWRlcnMgYmVjYXVzZSB0aGV5IGhhdmUNCmltcGxl
bWVudGF0aW9uIGRlZmluZWQgYmVoYXZpb3VyIChpbmNsdWRpbmcgdGhlIGNvbnN0YW50cyB0aGVt
c2VsdmVzKS7CoA0KQWxzbywgeW91IGNhbnQganVzdCByZW5hbWUgdGhlbSB0byBYRU4gYmVjYXVz
ZSB0aGUgQVBJIGlzIHN0YWJsZS4NCg0KRm9yIExpbnV4LCBqdXN0IHVzZSBpbG9nMigpIHdoZW4g
Y29uc3RydWN0aW5nIHRoZSB0YWJsZSwgYW5kIGRvbid0DQptb2RpZnkgdGhlIGhlYWRlciBhdCBh
bGwuDQoNCg0KQXMgZm9yIHRoZSBhY3R1YWwgZmxhZ3MgZXhwb3NlZCwgaXQgd291bGQgYmUgdmVy
eSBiZW5lZmljaWFsIG5vdCB0byBjb3B5DQp0aGUgZXhpc3QgcHJvYyBpbnRlcmZhY2UuwqAgSXQg
d291bGQgYmUgYmV0dGVyIHRvIGV4cG9zZSBhIHN1YmRpciB0aGF0DQpoYWQgZmlsZXMgY29udGFp
bmluZyBib29sZWFucywgYmVjYXVzZSB0aGF0IGFsc28gZ2l2ZXMgdXNlcnNwYWNlIGFuIGVhc3kN
CndheSB0byBmaWd1cmUgb3V0IGlmIHRoZSBwYXJ0aWN1bGFyIGZsYWcgaXMga25vd24gdG8gTGlu
dXgsDQppbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIgdGhlIGZsYWcgaXMgc2V0IGZvciBhIHNwZWNp
ZmljIFZNLg0KDQpBbHNvLCBJIHRoaW5rIHlvdSBvbmx5IGNhcmUgYWJvdXQgZXhwb3NpbmcgUFJJ
ViBhbmQgSU5JVERPTS7CoA0KTVVMVElCT09UX01PRCwgU1RBUlRfUEZOIGFuZCBWSVJUX1AyTV80
VE9PTFMgYXJlIGFsbCBkZXRhaWxzIHNwZWNpZmljIHRvDQp0aGUga2VybmVsIGl0c2VsZiwgYW5k
IG5vdCByZWxldmFudCBmb3IgdXNlcnNwYWNlIHRvIGtub3cuDQoNCllvdSBhbHNvIGNhbid0IG1h
a2UgYW55IGNhbGN1bGF0aW9uIFNJRk5fTlVNX1NJRk4gYmVjYXVzZSB0aGlzIHZlcnNpb24NCm9m
IExpbnV4IG5lZWRzIHRvIHN1cHBvcnQgcnVubmluZyBvbiBhIG5ld2VyIFhlbiB3aGVuIG1vcmUg
ZmxhZ3MgaGF2ZQ0KYmVlbiBzcGVjaWZpZWQuwqAgT3B0aW9ucyBhcmUgdG8gZWl0aGVyIGlnbm9y
ZSB1bmtub3duIGJpdHMsIG9yIChzbGlnaHRseQ0KbW9yZSBoZWxwZnVsKSBleHBvc2UgdGhlbSBh
cyAidW5rbm93biRCSVQiIGJvb2xlYW4gZmlsZXMuDQoNCkZpbmFsbHksIGFueSBjaGFuZ2VzIHRv
IHRoZSBzeXMgQUJJIG5lZWRzIHRvIHBhdGNoDQpEb2N1bWVudGF0aW9uL0FCSS9zdGFibGUvc3lz
ZnMtaHlwZXJ2aXNvci14ZW4NCg0KfkFuZHJldw0K
