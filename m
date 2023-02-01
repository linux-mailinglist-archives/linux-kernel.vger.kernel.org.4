Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C90686F12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBATne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBATnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:43:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08496FD04;
        Wed,  1 Feb 2023 11:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675280611; x=1706816611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VzcHJK/DKzDlw1lgEGs2saJIXUjkGM2G7Gl8VK54g0U=;
  b=NlNOe0ilGYWcFAee7L7wFfmIdq7CNpHlfJgOx3Jwr86Um4Ge+RKA8rID
   ecns8L3iGAnT3LsPYaAraifOzIq0d/cWyQ7FHxbg+ZW3aDYrqCaGL5Qml
   ZBK1BAVMdTIXqYGvAWNKQXEzGEa0NQptCXHhPC0GKya3sWRCKBeIbQ5m9
   shgJ9TWtB0Kl6odSo8nUr18RqRP5PSQTX1rG7CXS5yPkC2XgwaP3+PuBO
   BNn0wDZunLIuyMw4WyMaNB+psQ4iNa3+77ZlvPI2eoL2T0EO1KurP84jK
   1i5Q5g4nsjrcArX/QGhXBhgPfwwKP7xTzFZRxaPgRnrLr+HkuubiwXPuF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="307909267"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="307909267"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="753815672"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="753815672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2023 11:43:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:43:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 11:43:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 11:43:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWJWThzI5ZwKWAbiG/w9tNWuQ/riLsWiruXdj9QKqNCGP3Ol2uc/z6mtwEsdboDfboVuDdZobC584WMRvKnLm7hQkBoGe2vRBm07dqoSEEWG+5q+o3M6/2xwrST9cmsB3uM/RzoRrUkbw6EN4QoFv5+bMCybyjV96XWa2AeXnrNGNp/EWxwe7iGtFhfrjmqppjmuV7+vV5+F6RHfLWx72ZPB+uSdJEkBbIMLBFztAikF7J4cvptWejg2a43RCPIsD8KYZKSLpUysods0dmNY3m8kXNlk/3MbSQhSCngsW9KXDbyQorQbsIG1nYI0hRudXM2WEO2ftmIrK2gWP4imgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzcHJK/DKzDlw1lgEGs2saJIXUjkGM2G7Gl8VK54g0U=;
 b=JaX05rAYsledMBv2h5AD3PGenwUeoJQysplA4+/Sio4DNRmSKf4MNbV2tAj+k7W5qI2/9CvOoYo/+ps7EKi3n01iGJGzVscms/2rNw2hX3Slw1CNnSHgBzQs3aFZ9dwEnijfwRLjzRbOOy8zNC3Xu5p4/aDcqUGv98PzgHymBYykhw6VsNSPp54uohQAgtvJ0BKCar1gp9q4Zv2g2tm4qoIwx+Q/8ZbKscyVFB6DB5prB+3y0egDimTxOTHK/ddQsvi6KI7tJtlr3HR0Nlvhe/yno+BO+Ev1fiE/x9anS9f8em35oGD/H5zg7C4sZIboT1yE7EwiCBp6wtRtYc0YAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 19:43:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 19:43:23 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: RE: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Topic: [PATCH 4/5] platform/x86/intel/ifs: Implement Array BIST test
Thread-Index: AQHZNc4J4EU3Q3ktD0OwChsEsRbA+K66fSgAgAAA36A=
Date:   Wed, 1 Feb 2023 19:43:23 +0000
Message-ID: <SJ1PR11MB6083616D3AA5738944EE37DDFCD19@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230131234302.3997223-5-jithu.joseph@intel.com>
 <aedc760b-ca4d-031d-6797-4f0a1ab2d5d7@intel.com>
In-Reply-To: <aedc760b-ca4d-031d-6797-4f0a1ab2d5d7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5380:EE_
x-ms-office365-filtering-correlation-id: b3366e09-914f-41da-6c70-08db048c9462
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAMYfpjJf3sOhyQsz47WOREnClIsYqsd5nsTIzUO/bkkMXz+DS3tVsJVWy+AjmLH9pbWOIFMV6hItXbrldsO+MYvgrA0gBbanZ2tB/8peDCtQkVQwDScLOQeEzJDJSmJ7ZlSun7w3aJW+LodAmjQ3oJzM6N4nvdYGVFePZ2QdfXZ0DooV2feRfqou9lP1wZpxXxLnQdy7bXy1ltmY+ncBsf2NsbKUXkt7xEES9y7WLhnlawM4r/Fsyk4/3YKnk88S4P2/+W/xlMI38UOtnnxVKQyMBXSkBGmpJDy3r8k9Cs+lcPyFStY9VzW67FVC8xKU3FWZzyO2JOUBn67bEhxzcq55PX31hLLej1Li/+LSwWzAKkReg98H8c7N3zjFIr59Vqy+Lvq0/yZv7PPWlYwO3iuX+rq41CNs7z7rk22TBPtFjqbNSPGt9k+TURT9Vy8S46WIqdXCmoden4kWMKQWdZVpWIGNDhIfccpeNlr9INWGir/78YirOrsFoJHf1jMcVZtsY3iD1zuarmeDTzK0vyZQi4tL43SHGxJykrcB8CHkwXTmFUd3O9TkSXCr+m5Zfi0/LRGEDXnkgl2S4GmjltwduVLHeDSUiOWRf/imv2maaTzBC0aJXjc9JOSztv5REBTs7C9emiJs/DQnxGd7jn57ncfefaC55gsokJ5P3AA+17Gv4EHkCZlD7k98D66
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199018)(478600001)(7696005)(2906002)(82960400001)(9686003)(86362001)(76116006)(4326008)(66946007)(71200400001)(26005)(186003)(6506007)(5660300002)(110136005)(7416002)(316002)(66446008)(8936002)(33656002)(38100700002)(122000001)(52536014)(66556008)(66476007)(4744005)(64756008)(54906003)(41300700001)(38070700005)(8676002)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzU2V2NnNG5VMjQzQkdKcFlVL29yZHd5S2pvZFkxTThBbFRGZjVrcDJBMmY5?=
 =?utf-8?B?SXYwUTNiaktEUWFmM2NqSW9MT0xHQkp1ZmVvZENLOS9IUXhZSGlHNG1WR0pw?=
 =?utf-8?B?KzdZWnd6Y2FUaG1QNGE1Qm5YREZ2K2huOWJhRjhEa3Z5STREWW9hVWp1V3Yv?=
 =?utf-8?B?eUZHYmFXR3RDNHJKWEtPV3VQNnJvYUJXa0E0NDlMZVhFaURPMGQ0TTdWcUVq?=
 =?utf-8?B?MXpmSXYrSzV5YVJvcnViRDU0UkU5Z2hmSVJ2YzdCMHh6M1JBcysvYzZIWjNu?=
 =?utf-8?B?N3RBNWZYS0tza09KaldUbU9WSHdBQ1VjOXRDWDNvdU5LZTg1QzdBT3VwVDJm?=
 =?utf-8?B?eVlTQWtSb0tlN29SK0R1VnpTaGt5UmRkLzUwWXVXOElXSXpoSm9oT3FITk9y?=
 =?utf-8?B?d1ZzVjFZb0hJT0plT3BzdEhoaDhWb1J0ZDVlVW5XM1g2cm9YRnJvbjdxSkZ3?=
 =?utf-8?B?SjFmTVA2WDRDRXlVK0hRRXhkeG80SUFXYkw1TEgvQXE1NnAwV3pTTHRpZTZr?=
 =?utf-8?B?TjVlQVdaYWFPT2Frdy8wOUNkbTNldWkrOUVieDRxZUNLUENVUlJTdzlnTllT?=
 =?utf-8?B?OWJMbURxMjA4K3MrNU4yalN0RDBFemdGbmxzMFhuTzJzQXZOUGdybzNaVEU4?=
 =?utf-8?B?Y3BFeTM1MDdTTkY0NUgzQWdHdllsS3Jpc21tOENXQTV4N2tyZE5iakxPUWxv?=
 =?utf-8?B?cFI5T2lrVWw1VFNYcDl5bURBWmJTVE9ETW9ZSVFWUTFmRGlwQ3NHU3BNZjFZ?=
 =?utf-8?B?OSs1VEIrWW4vbXBqSGxQa1ZtVXFCZEVxbzMwQVA1Mk85Nk9HaVY3OVdZRkJl?=
 =?utf-8?B?WU0zbHl0d2ZqT1lFd1Zrb0x3UzdGTVQ3L0xDWGxHTVJTekRSTmx3Y0phQVZz?=
 =?utf-8?B?WXRoa0lxa2ZhbWdiNDdHZitmR3JGYkhqeElOWFVCQ0t1TmpIZnd5L1RqeXIx?=
 =?utf-8?B?LzNLN2NYWlVPWWc0RWpvWHd0T1VqS2V5NHlnRFpJbG1ZbGUyb3NJR3hSaW8x?=
 =?utf-8?B?WUdScFdHOUxwSVJRSFY5MWRVc1JhQUNHK3ZKVk9zSXZhdHNWMlFXY25YRnJK?=
 =?utf-8?B?WWhXbEJjcEJsclFWV09LZ0dKZzd2VkV4RzJwcHVpdjJvWWVmRmFaMkRBbUxo?=
 =?utf-8?B?TGJkV0o4bFZQczZEMGtrR0FpRkRsVEhyZU5kT0dNclEzSWF0d0x1V1lQd0U4?=
 =?utf-8?B?cnh6OGFBRCtnWWcxOHdWOTRydFgydFlPN2tQVlpVLzl3RHIreTVJbFVtcnpN?=
 =?utf-8?B?d2MxYzlOZDZoeDJlRW1vK0dBNmc0V1JzWHczUzN4K1RmQUp3QjNUc2s0WmZM?=
 =?utf-8?B?VENWRk1rQmlGTzh2eGRBa21weXhpdGpnemdLb0NseFlLOTZMOW1jNU1NNGhX?=
 =?utf-8?B?WkFwcnBPeXlKQi9JTVlkOEwxRkRPektBMHQ5SXJINmNwZW9zVXk1YXBGSmZW?=
 =?utf-8?B?Z29DSVNySXJzK09TNHRpb1h1K255NHBjUklFUmNFckJ6Z1ZWUkJWN3ptME1L?=
 =?utf-8?B?VnRJT3p4YTczUTY3SWZKUXRUZVR5dG9jQVVQa2dJSlRWeWlRbUNKeGpUNkQ3?=
 =?utf-8?B?ditieUZ0YUVmb1N3aFdrOW1qRHlaZzJXeHpPaVgwSVhqUlB1MVo0YTA3V3B6?=
 =?utf-8?B?TDE2bDU0TDZ5REJ4MCt4OUFJZ0pjbnc4eWtqWG1kQnBoWU5OaCtDNSsvNFFD?=
 =?utf-8?B?UnlSUitFMjY5YjRybUp3NWFIZWlZNk1sR2cva3FmUW1oUzVlbjkvbDBHSHI0?=
 =?utf-8?B?ZXRzWHFvN2tWZUQzN0tNaU0vc1BLeGlLbVpxNEp3S05MSkpLdDhXaTMvOEFt?=
 =?utf-8?B?WjlkZ3Q1SFJ0a0lRdjJjSEVlUGkwc3RVc21VeXlMU20yRDV3N202S3RmMjBL?=
 =?utf-8?B?bnpEK2d3K1RkM215V0djWVNTRUJyZTRSS29WYW9PSytxOCtya2pFZHFxay9W?=
 =?utf-8?B?Y1VNV3ZoakRWUzBDWUJ6d0pobXZwK1hEK25NZFpxU3FUL1FwWjBWZk9xTzFl?=
 =?utf-8?B?NS9oWWJud1d4M0F5MDZzM3BQakJidndrTml2QnZGVEE4VDVsQjQzSERhZ2pM?=
 =?utf-8?B?a2dlN3p3MTROT2lNR2pOdVdSd3UzbWtkMTRiUTRlay96WVZCd0VMbnJ4UGRO?=
 =?utf-8?Q?R4/l91vAdls17q2tqfVlZZlUt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3366e09-914f-41da-6c70-08db048c9462
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 19:43:23.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mocD0wycipTRTiEJ7MNvz7QXUnDfSZiwgaquo+V35S3kkOM/fhjSbDV3v+rINB5Ku8c3WB0Keylg51Ifm914yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5380
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBXaHkgYm90aGVyIHdpdGggYSBiaXRmaWVsZD8gIEp1c3QgZG86DQoNCkhvdyBtdWNoICJib3Ro
ZXIiIGlzIGEgYml0ZmllbGQ/DQoNCj4gdW5pb24gaWZzX2FycmF5IHsNCj4JdTY0CWRhdGE7DQo+
CXN0cnVjdCB7DQo+CQl1MzIJYXJyYXlfYml0bWFzazsNCj4JCXUxNglhcnJheV9iYW5rOw0KPgkJ
dTE2CWZsYWdzOw0KPgl9Ow0KPn07DQo+DQo+IFRoZW4geW91IG9ubHkgbmVlZCB0byBtYXNrICdj
dHJsX3Jlc3VsdCcgb3V0IG9mIGZsYWdzLiAgWW91IGRvbid0IG5lZWQNCj4gYW55IGNyYXp5IG1h
Y3Jvcy4NCg0KIm9ubHkgbmVlZCIgdG8gc3BlY2lhbCBjYXNlIHRoaXMgb25lIGZpZWxkIC4uLiBi
dXQgdGhhdCdzIGV4dHJhDQpjb2RlIGZvciBodW1hbnMgdG8gcmVhZCAoYW5kIGh1bWFucyBhcmVu
J3QgZ29vZCBhdCB0aGF0KQ0KcmF0aGVyIHRoYW4gdGhlIGNvbXB1dGVyIChjb21waWxlcikgd2hp
Y2ggaXMgcmVhbGx5IGdvb2QgYXQNCmRvaW5nIHRoaXMuDQoNClVzaW5nIGJpdGZpZWxkcyBpcyBh
bHNvIGZvbGxvd2luZyB0aGUgZXhpc3Rpbmcgc3R5bGUgb2YgdGhpcyBkcml2ZXIuDQoNCi1Ub255
DQo=
