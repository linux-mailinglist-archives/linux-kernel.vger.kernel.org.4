Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242396F1214
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjD1HBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjD1HBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:01:44 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1DE7B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682665302; x=1714201302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u0YR77Rv4hYx6ncjBAJF5XwZSzPAEUGVK4e8Sgu1QaM=;
  b=ZxiQpMyh8mRcfUOI3+uRrHxdrbSuIcgq8dF/DSAyWOjNYZ8HjTnVjvR0
   WdmZ/8K50xxDOjutvfzGN0FiQpUyDoF1JlmdCY5ZWfDPkCelQQme40BU+
   WjW5nlD60+GqtXzRlMlrk16YVnBRAcCzTJqVd5QtHeLKwYFS3B7k6V+FD
   WDFEiuVit9SfVZuoShOmzLzSMybHCm0x3SoZeo6MMAkqJWvctFh8AyVQh
   xFDA8Aby2iLQB6YkW41M/TsUazUL9sFHaylVXdQBpt0XjImi66wXON1G/
   FVPLR7fV+Uov1rP1MVjTmmOj7ieTffEQnzMc0zhC42ervYr+wIoa1KItI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="83283572"
X-IronPort-AV: E=Sophos;i="5.99,233,1677510000"; 
   d="scan'208";a="83283572"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 16:01:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOEn/2vJ/P71Yaftu3APtLJ/TsRfLZAWQcHzVHGp5UasND67ikK6PD3YLQJ6viAXFUtjFWQB92FcEY1ENt4Kn6KDE5fiIWLhx4L5jJlzZrin3B2AosK6YL0txkXUpGZFY1jeE7HFpFLrmrpwl1TmRLk5nl4GstGwEWSJp5GBRN8t02fLkrIzOYhJ4ouRZrHqppjVxfkU3+5rmvKwgofFM0dh5UyN5nxDUIGan/74oS9+aelZBI3caHRKIIhqhxmz8YWDnB1xDmFZqYEfycSA8W+qKweWgKXzFWnV8DM81TBCezlu9kWejo9nki23c87P4YLOtQ7/cmApzqQbc1MZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0YR77Rv4hYx6ncjBAJF5XwZSzPAEUGVK4e8Sgu1QaM=;
 b=YebE1M+9o6Zcmhct/VxLGYmHG7t2Ybdmhh4wTtzhQ3Jv7lK2oQDz9Oip0TV/+m1KBSww/zAO8XIzMh/PSstTRJ3PHUDDMt/a76cFHAtvF5TUWlbcD/2WCh0ayWj0fbGrXTM86P3n8KaW4piJzXg6F7asBT3xTE0sTF1sC2gnL2//V0RGQRD1QF7gkcAGde7XboApPfzhY3LzlqvWjRJJDUYw3FCoFBYxOoAeczQsLK0W6djx2VHrLSMZe6V6KjLwn0WTfN9wmK+VwTVzKH+Zj9ZgT7Gyxonr4PisExcsSr/8KS2uSDIppW8KloXpelfQcSsD3zaYbcCFTpLiSigSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSYPR01MB5528.jpnprd01.prod.outlook.com (2603:1096:604:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 07:01:35 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 07:01:35 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Ira Weiny <ira.weiny@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to
 vmcoreinfo
Thread-Topic: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to
 vmcoreinfo
Thread-Index: AQHZePGnF9oCmES6tEaat9zuqzcMKa8/w2KAgACJQoA=
Date:   Fri, 28 Apr 2023 07:01:35 +0000
Message-ID: <541c8d7c-5912-5446-5e7e-0feeae911de8@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-3-lizhijian@fujitsu.com>
 <644afc2952c25_1a1c5294e0@iweiny-mobl.notmuch>
In-Reply-To: <644afc2952c25_1a1c5294e0@iweiny-mobl.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSYPR01MB5528:EE_
x-ms-office365-filtering-correlation-id: e2cc4b33-b5c6-4b10-bb31-08db47b66797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Wd0hQ3YJ+g+VRH9T4Ly9NQa9345UOx36ww4lWX3V6pn2ULInibXtI1xXlfD4kIzO+7JcNGF3wvtWAZVsr8GD8XE1zlUTq64gn07e2cOv357lX1t1CzbsSISXQVU+zsL5pfOfHh768xRpLtfavUDc7MTa2slV8mZCymnSAu6cP1EnxEeATPnJfUp0WBtKbQZG3O7QqqcOVcMlBurWKnfP8eNbABewHsvoJjtgPleFwbOn5D19GzqfJBoRE4CkT24/5e8jFlSOjZIii7Ohkw8sunz11MVwYHkj7pBX6ixfJgX8F/l9NowQh0p60rjmOG8168KS0f5pTvk8Pm/28m88k/HthimOh6g+Uc6kMxnkGamgu8AfsXyn4WT5pSKQprrbL5mXhGnJlfJ/C0FGw2CVmvWGOb5FxN0deACFB6TJ/arVwmUSQkHYc+hzsgT6iC9AVw2foqEAxE1Vi1+tiipfvXBuPgXfyY+8Sk4l/L1X/NVV0AS/t+Y49Zw59oajr0FwIgogbzY+DYQ6uy2jyhHVYoiAHecXZtpES0L38Wae4TA34mXkJCBnQptyr7Uk3KUZWHXrh2n7VDWM1Ux2kJ0eoC/zQvDO32jojzSjopqdh4zLwgykbVHOgtbtsm3TlJgp2WNxS5g9M/WJq0+/jn8RX8rJOZMBd76m+SsCk3ybJJRLiOYrV/ogVvPJ2/4mP0pSLbDwO7qL9Ay6ntyDluujA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(1590799018)(451199021)(1580799015)(38070700005)(5660300002)(8936002)(8676002)(41300700001)(478600001)(86362001)(54906003)(85182001)(66446008)(316002)(6486002)(36756003)(76116006)(83380400001)(110136005)(31696002)(66556008)(66476007)(66946007)(64756008)(71200400001)(4326008)(91956017)(82960400001)(186003)(38100700002)(31686004)(2616005)(122000001)(53546011)(2906002)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2M3bytMR1gzTHZhdWsvMU14c242WkJhNlhuQklraW9QMmt3ZDBVeGxPN2Yw?=
 =?utf-8?B?K0t0U2tObmx5S0VBRkIvbFk4VTQ2MlpPYjltWHVIUjVDNGhzcGtYaCtKMlpx?=
 =?utf-8?B?NEJaUUhtYVR3V2dYVjZpdHF3RTFuOVMzOCs3Mzk0UVpkYyticldZU3RPaWxz?=
 =?utf-8?B?bWpsaHVOR1FuUjI4NnVJdXdQb0UzOUJ3TnBZUW42aHZsdlo2ekZtOWhOUzlx?=
 =?utf-8?B?Um8yblF6RnZiRGNWckd3VjdRMmpWUGhMUjM1OWl2Q005SFlTaG5zZWl0TEtQ?=
 =?utf-8?B?dGRpZzdyWnNlVTZYTGJvakZ3cTQyd2xuT3E2MVNsem1kL2x2ZE5UbG5OYnVr?=
 =?utf-8?B?MmlRM1ZNOThHVWY5am5aclM3NHpRWVhNb1JuS3Uvbk1vVnQrNTEzcXlTMmRX?=
 =?utf-8?B?a0NycUhhVGZqajdSOEFPK2ZJU0N0MlI1cHB2ZXdwbUZqZVRMUlVacTBGMlhx?=
 =?utf-8?B?NlZmb0xweDV6ZjFsNXVUQVJXMkFzUWlxQU13dllWQWsxa0NYdlVocGdpT0F6?=
 =?utf-8?B?dWljeW1zTXovNG1BMk41UitQZGdDUWFvaU9LelFYSkUrQytOcjhQYkhva3dP?=
 =?utf-8?B?NTNlSmFDYitNMXBYbjJYTE40b1doS3BqRTNZUGZWT3JmaE91S1JITTAxUnd6?=
 =?utf-8?B?a3J0TkRURDl2V3FaVGU5dytaSDVwN2ZqUm5qOXVWbXhxT1pQVnNCWS9Mc0xY?=
 =?utf-8?B?TW5mTUJkUTVudzJ4MGJ6RVVaSmtrdEdmaXF2Ni9OQ0NOTGxEc3YrRCsvNVpE?=
 =?utf-8?B?L1Y3YVpuMlpveUl5WUxoN09IVGUzaXVoMHJ0dU5hbHBTUE82ZlhHVTlvTGZI?=
 =?utf-8?B?RXNrdGtmV0ppZGsvMTZST0JEb2RWRkZnb0p6dVJIS1hOWVNlbnZMdERDbCsx?=
 =?utf-8?B?d1hKRGQza0hGbG03eHY2aVlkSmRjYVZvVzlwNHlId1RvNjU1M2dtaWEzSzc4?=
 =?utf-8?B?TU1WMGJUVXdGdk5idDNtKzBKR0Zmd2l4NzJhYm5Sc3BJZTNIdllyQWNrK2Vi?=
 =?utf-8?B?dlF6Wk9GUlJGV29DVzVhZ3lUUVpQejczR3ZBM2xSUWg2YlJhSVNUNWlneENa?=
 =?utf-8?B?RUdpSEVqSVBBb3B0QmNqUDBlcFRPdHUwRktKdXg4NWNLTHhGVDErYWp5MGxW?=
 =?utf-8?B?VFpXUmZDQ1J1SzhSYk9DN1RhZkdreU5VbmdVNVJaZmsxMXo1a1d6b1BLeUZU?=
 =?utf-8?B?QVZjTUU0RkluVXpUMmRETU1Mam14dGZkUS82VVpVb1pCT2F5dTU3Y0svSm5n?=
 =?utf-8?B?L2dHc2lVQmVGNmtmREJaVWZzSjZySXExM1ZWbWpwSUM5eHRiSWdEZ1NKUUE1?=
 =?utf-8?B?eWw1ck9JeVh4YjZkZ1pWeFN4TEg3NWZQWkI0Sk54dnlQV09YNmJ4emJXK0ZX?=
 =?utf-8?B?NGNMR0MrSEIvN3RNY29JcEdJUXRMditSYkwrZU1VTUxxSlFsSTg4RDBQR2hv?=
 =?utf-8?B?Ni9MNGFNbVZUcXFRSW9jYlozcVpPVTFnU0V5UlhMaGtERVRhUGh6RGdMTjVO?=
 =?utf-8?B?WWQrdTdUNnl4M3ZycENBa2FqMC9obElnYUd4YXhWc0lmSytObEhSVHJJSEEr?=
 =?utf-8?B?clJNTzVVZk13cjdMTDQwVVZVakhORUtFZTFEeUxwRWZYMkdvMzJtejNZbm1n?=
 =?utf-8?B?VDRZOEoyeFJoYk5RWXlGYUcxbWU5VVIrRXAyaWo3akNoTkNxbHJPSHpsZVUv?=
 =?utf-8?B?Y0pwVUxHbm5SWE9lZ3E3N2dINUtid01wbXBLSkh1R2FhQmEyUGZkZy90OE1T?=
 =?utf-8?B?aFh1NHhBbVFsazVOYWJITnVvOUR3WHFWT2xweU1EYVpCRThpQzBHNEUwS1Ry?=
 =?utf-8?B?djgzU0d6Lytaek5nQWM0VUIvUlZKcS9SUGdubkcvWjF2cUNFUmF5eVJIK3pu?=
 =?utf-8?B?SEJzbG1Oc212MHJHMjlSNk5JcGhwTXZvczhxVXRwdXVXN05lUHZPWDFmSzdz?=
 =?utf-8?B?UXVvK0xLWGlOUVBaV3JBVDVITi9FOTJOeWZaalk5MjZmRlFoYlNkT3pyeVhz?=
 =?utf-8?B?ZnBmcEpOVjhjb3FGTFlyV3VoYXc1Z3QvZ0JYaTJJR3dxUldwNEltZmNYZHFz?=
 =?utf-8?B?MVZKOHpuMXN4bFN3VUs0VGdld2JlM0FmNTZ6ZHJicnl0aTNEbkFGdEZMR0Nk?=
 =?utf-8?B?YjZXdnhML2xRUWczbWl1YURPK2pvakxrbm5uNFNZVmV5NnJ4eWFZNGZESnBr?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4B8B4F542D4848AB3E7D9E5DAB7D8E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yTcFcqXjMS1sZP6rAq9AMrbkmtkL80BiX6d8SBjub5TPmz8hYmxb9MPKHLaw8QfIP+L/ILTTEg65NwDnV4XldR97HbhhNut9m66Uj1heeaHsQobNR3ASDXfTuo4dIpi0ZoU/PatEJXkWnZvgcElRcj7v1gav31AA4X6RRDa2ZQcK8VGNoTQOnfQ5B1AUFDeoynF3F7ZHEMYTlANqy5EMRlVz67ViU0kl74Wj5Sv2jUtScSLgjjqqbZnCshAH9GN0Zx62yCj2l4K/6t3slEfe/3nIb7qCrcYN4RFMcDTrVLR1gWd4wh4LuzG5sqR3KZJoSW2fFxzm41y5NRuUaAJO++XJWdURaq2DOeZkdNyC/5vznUFLKFzx1j3+V+wc0U9noRJFwKEieaFvQmaBRgn5QZS99hhUiF1PubgNZngIhLF6eVAShfGJevuOCF2DcRP5yHb1bKPs1qkVHk45a7m8gDkHECXeJUDZBQkTK2x/GvIXWgkhW0h2BOsoqPEtfkmkwpa1VqOsQ9rzhIZXDQ/HVzK1ikdyA4ZCrVFUvAkQAOOS0JJcrC9YkRfA7Jb2/gBPBkJR1N0r+ulHpEFSglkpnmYGcsUiJuPDgKDdb6nFrD96h8cTTb/XjHxxsvz4mH3M1etErXh1RCwtu2TTt89A28fnb7HRkh3GbKH1E88scyLrT/R9V/Dez3vDr9WChwIssKGpCmgYyglzeGJ0QMRbPNQ5ZkBJE/2n+TfwzvyhjkFPA1w11wx+nw6hBRpL5kAUffNGynHHDGTmv/piIlt1WFoJJGeCtvX7CX5joM7Q9HCB1+MPV63jZHbV2iHmrP0yhPcxHew8OGB6fvrHGu6wN/v2tpnbg7CtdxVdL8JQGa0TOxUd2sd5UQSAQueHGeSVG/pibmdtvDko5J68pcvtSjZRxO/s3kjdl2qr1QDHgQ4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc4b33-b5c6-4b10-bb31-08db47b66797
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 07:01:35.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cU1/t8x+GAyWtxmOiC7q3KO7RdSfK5ndmrG2wuSm2sdcMO6zF2sqxFxJyrgWPWKyXMepEuwDYd2U1fo4tsOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5528
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LzA0LzIwMjMgMDY6NTAsIElyYSBXZWlueSB3cm90ZToNCj4gTGkgWmhpamlhbiB3
cm90ZToNCj4+IEVhY2ggbmFtZXNwYWNlIGhhcyBpdHMgb3duIG1lbW1hcCwgaXQgd2lsbCBiZSB1
ZHBhdGVkIHdoZW4NCj4+IG5hbWVzcGFjZSBpbml0aWFsaXppbmcvY3JlYXRpbmcsIHVwZGF0aW5n
LCBhbmQgZGVsZXRpbmcuDQo+Pg0KPj4gQ0M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNA
aW50ZWwuY29tPg0KPj4gQ0M6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
Pg0KPj4gQ0M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPg0KPj4gQ0M6IElyYSBX
ZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4g
PGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL252ZGltbS9uYW1l
c3BhY2VfZGV2cy5jIHwgMiArKw0KPj4gICBkcml2ZXJzL252ZGltbS9wZm5fZGV2cy5jICAgICAg
IHwgMyArKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYyBiL2RyaXZlcnMvbnZk
aW1tL25hbWVzcGFjZV9kZXZzLmMNCj4+IGluZGV4IGM2MGVjMGIzNzNjNS4uMDk2MjAzZTYyMDNm
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYw0KPj4gKysr
IGIvZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYw0KPj4gQEAgLTgsNiArOCw3IEBADQo+
PiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+
DQo+PiAgICNpbmNsdWRlIDxsaW51eC9uZC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9jcmFzaF9j
b3JlLmg+DQo+PiAgICNpbmNsdWRlICJuZC1jb3JlLmgiDQo+PiAgICNpbmNsdWRlICJwbWVtLmgi
DQo+PiAgICNpbmNsdWRlICJwZm4uaCINCj4+IEBAIC04NTMsNiArODU0LDcgQEAgc3RhdGljIHNz
aXplX3Qgc2l6ZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiAgIAlpZiAocmMgPT0gMCAm
JiB2YWwgPT0gMCAmJiBpc19uYW1lc3BhY2VfcG1lbShkZXYpKSB7DQo+PiAgIAkJc3RydWN0IG5k
X25hbWVzcGFjZV9wbWVtICpuc3BtID0gdG9fbmRfbmFtZXNwYWNlX3BtZW0oZGV2KTsNCj4+ICAg
DQo+PiArCQlkZXZtX21lbW1hcF92bWNvcmVfZGVsZXRlKHRvX25kbnMoZGV2KSk7DQo+IA0KPiBU
aGlzIHNlZW1zIGxpa2UgYW4gb2RkIHBsYWNlIHRvIHB1dCB0aGlzLiAgQ291bGQgeW91IGV4cGxh
aW4gdGhlIHJlYXNvbmluZw0KPiBtb3JlPw0KPiANCg0KDQpJcmEsDQoNClVzZXJzIHdobyB3YW50
IHRvIG1hbmFnZSB0aGUgbmFtZXNwYWNlIG9mIHBtZW0gdXN1YWxseSB1c2UgdGhlICduZGN0bCcg
Y29tbWFuZC4gVGhlIGZvbGxvd2luZyBjYXNlcw0Kd291bGQgdG91Y2ggdGhlIG1lbW1hcCBvZiB0
aGUgbmFtZXNwYWNlLg0KDQphLiBjcmVhdGUgbmFtZXNwYWNlICduZGN0bCBjcmVhdGUtbmFtZXNw
YWNlIC1mIC1lIG5hbWVzcGFjZTAuMCAtLW1vZGU9ZnNkYXggLXMgJCgoKDEwMjQrMTYpPDwyMCkp
IC1NIGRldicNCmIuIGNoYW5nZSBuYW1lc3BhY2Ugc2l6ZSAnbmRjdGwgY3JlYXRlLW5hbWVzcGFj
ZSAtZiAtZSBuYW1lc3BhY2UwLjAgLS1tb2RlPWZzZGF4IC1zICQoKCgxMDI0KTw8MjApKSAtTSBk
ZXYnDQpjLiBjaGFuZ2UgbWVtbWFwIGxvY2F0aW9uICduZGN0bCBjcmVhdGUtbmFtZXNwYWNlIC1m
IC1lIG5hbWVzcGFjZTAuMCAtLW1vZGU9ZnNkYXggLXMgJCgoKDEwMjQrMTYpPDwyMCkpIC1NIG1l
bScNCmQuIGRlc3Ryb3kgbmFtZXNwYWNlICduZGN0bCBkZXN0cm95LW5hbWVzcGFjZSAtZiBuYW1l
c3BhY2UwLjAnDQoNClVubGlrZSB0aGUgZm9ybWVyIDMgY2FzZXMsIHRoZSBjYXNlIGQsIGl0IHdp
bGwgbm90IGludm9rZSAnX19udmRpbW1fc2V0dXBfcGZuKCknLiBJbnN0ZWFkLCBuZGN0bA0KanVz
dCBkbyBzb21ldGhpbmcgbGlrZSAnZWNobyAwID4vc3lzL2J1cy9uZC9kZXZpY2VzL25hbWVzcGFj
ZTAuMC9zaXplJw0KDQpXZSBoYXZlIHRvIGRlbGV0ZSB0aGlzIG5hbWVzcGFjZSBmcm9tIGRldm1f
bWVtbWFwX3ZtY29yZSBpbiB0aGlzIGNhc2UuIFNvIGhlcmUgaXMgYW4gb2RkIHBsYWNlDQpidXQg
aXQgd29ya3MuIEkgaGF2ZSB0cmllZCB0byBmaW5kIGEgcGxhY2UgcGFpcmluZyB3aXRoIF9fbnZk
aW1tX3NldHVwX3BmbigpLCBidXQgaSBmYWlsZWQNCmF0IGxhc3QuIElmIHlvdSBoYXZlIGFueSBn
b29kIGlkZWEsIHBsZWFzZSBsZXQgbWUga25vdyA6KQ0KDQpUaGFua3MNClpoaWppYW4NCg0KPiBJ
cmENCj4gDQo+PiAgIAkJa2ZyZWUobnNwbS0+dXVpZCk7DQo+PiAgIAkJbnNwbS0+dXVpZCA9IE5V
TEw7DQo+PiAgIAl9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vcGZuX2RldnMuYyBi
L2RyaXZlcnMvbnZkaW1tL3Bmbl9kZXZzLmMNCj4+IGluZGV4IGFmN2Q5MzAxNTIwYy4uODAwNzY5
OTZiMmRhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcGZuX2RldnMuYw0KPj4gKysr
IGIvZHJpdmVycy9udmRpbW0vcGZuX2RldnMuYw0KPj4gQEAgLTksNiArOSw3IEBADQo+PiAgICNp
bmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPj4gICAj
aW5jbHVkZSA8bGludXgvbW0uaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvY3Jhc2hfY29yZS5oPg0K
Pj4gICAjaW5jbHVkZSAibmQtY29yZS5oIg0KPj4gICAjaW5jbHVkZSAicGZuLmgiDQo+PiAgICNp
bmNsdWRlICJuZC5oIg0KPj4gQEAgLTcxNiw2ICs3MTcsOCBAQCBzdGF0aWMgaW50IF9fbnZkaW1t
X3NldHVwX3BmbihzdHJ1Y3QgbmRfcGZuICpuZF9wZm4sIHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdt
YXApDQo+PiAgIAl9IGVsc2UNCj4+ICAgCQlyZXR1cm4gLUVOWElPOw0KPj4gICANCj4+ICsJZGV2
bV9tZW1tYXBfdm1jb3JlX3VwZGF0ZShuZG5zLCBhbHRtYXAtPmJhc2VfcGZuLCBQSFlTX1BGTihv
ZmZzZXQpLA0KPj4gKwkJCQkgIG5kX3Bmbi0+bW9kZSA9PSBQRk5fTU9ERV9QTUVNKTsNCj4+ICAg
CXJldHVybiAwOw0KPj4gICB9DQo+PiAgIA0KPj4gLS0gDQo+PiAyLjI5LjINCj4+DQo+IA0KPiA=
