Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68036874C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBE5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBBE5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:57:13 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 20:57:11 PST
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8F64690
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4095; q=dns/txt; s=iport;
  t=1675313832; x=1676523432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LWdoASyToIDCW6K+evJHBmtW3oyxMNeLCskEV9Yctq8=;
  b=XC3cotclPAhmS+Zwmia6oAl6Ks8cDPFi8f72lzPcIPJLgxDM/IsjIzTw
   0ZMY2dKi79IbCtB1fXUOfPqjvriHoXSqBqizXCAJv4lr4jzJMDDYDN6BQ
   XGEHbLCBplaxqqhc9lOEvLxHVbcUVQ80Wm8LvvS7SEzeeMl1YyUhtxj0W
   Q=;
X-IPAS-Result: =?us-ascii?q?A0B1AAASQdtjmIwNJK1QChwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE+BAEBCwGBWlKBBls6RYgaA4UviCEDgROES4wsKYU0hCyCUQNWDwEBAQ0BA?=
 =?us-ascii?q?UQEAQGBVAGDMgKFJAIlNwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEF?=
 =?us-ascii?q?AEBAQEBAQEBHhkFDhAnhWgNhlYBAQEDEhUTBgEBNwEPAgEIGB0BEBAiJQIED?=
 =?us-ascii?q?ieCXIMjAwGdYgGBPwKKH3iBATOBAYIIAQEGBASfHwmBQAGRJiccgUlEgRWCc?=
 =?us-ascii?q?zc+gmICgTMthj+UEYgrCoE5d4EkDoFGgQ0CCQIRc4EbCCI3A0QdQANGMgo/N?=
 =?us-ascii?q?QsLSisaGweBBiooFQMEBAMCBhMDIgINKDEUBCkTDScmaQkCAyFfBQMDBCgtC?=
 =?us-ascii?q?SAfBxURJDwHVjcBBQIPHzcGAwkDAh+BbiQFAwsVKkcECDYFBhw2EgIIDxIPB?=
 =?us-ascii?q?iZDDkI3NBMGXAEpCw4RA1CBTgQvgV0KBgEpJqAaLhA+gUQ+QSgcL5VNAYtKo?=
 =?us-ascii?q?WUKg3ShMqkeLYcmj3ynbQIEAgQFAg4BAQaBeCSBW3AVgyJSGQ+OIAwNCYNQk?=
 =?us-ascii?q?k51OwIHCwEBAwmMIwEB?=
IronPort-PHdr: A9a23:BkiHhB96zp+eHP9uWCXoyV9kXcBvk7n3PwtA7J0hhvoOd6m45J3tM
 QTZ4ukll17GW4jXqpcmw+rbuqztQyoMtJCGtn1RfJlFTRRQj8IQkkQpC9KEDkuuKvnsYmQ6E
 c1OWUUj8Wu8NB1eGd31YBvZpXjhhQM=
IronPort-Data: A9a23:Po9rLKgnfFwx/ex3cSqAvoGaX161SxcKZh0ujC45NGQN5FlHY01je
 htvXGHVb/yJZTb9coolad7l9xgD6MeGztEwSAU5ryhjFSNjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En03FFAMpBsJ00o5wLZj2tQw2LBVPivU0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMq
 0kv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9IHRB4Mgg/Qwuldk
 uQTtbqyVz43L5flzbF1vxlwS0mSPIVP/LvBZHO4q8HWkAvNcmDnxLNlC0Re0Y8wo7ksRzoQs
 6VDbmlRNnhvhMruqF6/YvJsj8AnPc/DN4IEsXYmxjbcZRojac2ZG/ySu4MFtNs2ruUfAeveT
 fMBUjdQRlfxXRxVNXQWDKtryY9EgVGmI2EH9zp5v5Ef5mnY5ABw37nuN9aTfNGWLe1Rn0CFt
 ifP52XRHB4XLpqcxCCD/3bqgfXA9Qv/WYQPBPi7++RsjVm72GMeElsVWEG9rP3/jVSxM/pEN
 0EM+ico67M3/UivQ8i7QBqio1aLuxcdX5xbFOhSwBmAzKXJ4gDcBWUeSDNFQN1jsMgoSHox3
 1yUhdqvAzEpsqX9YXCa9rHSrzSyMC4OIGkqbiYCSg0E6NDn5oo0i3rnTdtuC6Wyid7dEjHqx
 DWLsS14gK8c5eYJ0qKh51HcqzSlo5XICAkv6W3/WmOj8xM8f4Ouepap9Ume6PFMMYKUZkeOs
 WJCmMWE6u0KS5aXm0SlWOwQGJmx7uuBdTjbhkRiWZIm8lyF8He4cJEW+zp+LVpnNsseUT7vf
 ELX/whW4fd7N3KxYL5feImxAtkkyaX6UN/sEPvTa7JzjoNZfQuD+mRlYlSdmj+rm0k3mqZ5M
 pCeGSqxMZoEIb9KlWG/fb5A6JNx934+42HNfI7q9T3yhNJye0WpYbsCNVKPaMUw46WFvBjZ/
 r5j2y2ilkk3vArWP3W/zGIDEbwZBSNhW86u+qS7YsbGc1U+Qz17YxPE6el5I+RYc7JpevAkF
 51XcmBCwVzzzUXdIASQa30LhFjHAssn8ChT0cDBwT+VN5ULaIKr6uIUcIE6OOZh/+14xvkyR
 P4AEylhPhitYmqfk9j+RcCixGCHSPhNrVnVV8ZCSGNkF6OMvySTprfZkvLHrUHi9Bafu8oku
 KGH3QjGW5cFTAkKJJ+IN6/1kA3r5ihCyLkas670zj97JRuEHG9CdnKZsxPLC5pkxejrn2HDj
 F/GXX/0W8GU+tNpmDU2uUx0h975T7QhdqarN2La9r2xfTLL5XauxJQobQp7VW61aY8Aw437P
 b8956ilaJUvxQ8W26IiSOwD5fxluLPSS0pyk14M8IPjNQr7U9uN4xCugKFyi0G67uYA51TpA
 xrXpoIy1HfgEJqNLWP97TENNoyrvcz4UBGLhRjpCC0WPBNKwYc=
IronPort-HdrOrdr: A9a23:UkK7qalMt2ew2j+y1OEHwqruyw3pDfOHimdD5ihNYBxZY6Wkfp
 +V8sjzhCWatN9OYh0dcIi7SdW9qXO1z+8Q3WGIVY3SEDUOy1HYU72KirGSjAEIeheOu9K1sJ
 0AT0EQMqyJMbEXt7eZ3OD8Kadc/DDlytHnuQ699QYXcegCUcgJhG0Vanf5LqQ1fng9OXNTLu
 v62iMznUvYRZ1hVLXcOpBqZZmnm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4k3Ez5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXAISaCUmRUXee
 v30lId1vdImjfsl6aO0FzQMjzboXQTArnZuBmlaDXY0JXErXkBerR8bMpiA2rkAgwbzYlBOG
 Yh5RPCi3KRZimwxxgVruK4Jy1Chw66p2EvnvUUiGEaWYwCaKVJpYha509NFowcdRiKoLzPPd
 Meev003swmOG+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljNYnahNAaVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOUMOm7LqZTw/LIpjdvaM6Ag3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTXTGC0TV3Wu7ZjDlhCy8nBrZbQQFi+oQoV4ridSt0kc7/mZ8
 o=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,266,1669075200"; 
   d="scan'208";a="52010645"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Feb 2023 04:54:05 +0000
Received: from mail.cisco.com (xfe-aln-001.cisco.com [173.37.135.121])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 3124s2VA010115
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 2 Feb 2023 04:54:04 GMT
Received: from xfe-aln-001.cisco.com (173.37.135.121) by xfe-aln-001.cisco.com
 (173.37.135.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 1 Feb
 2023 22:54:02 -0600
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-001.cisco.com (173.37.135.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15 via Frontend Transport; Wed, 1 Feb 2023 22:54:01 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOko3nlH6t6tjeCB+KZ4wYhCte0hqUzvu3FN03p781+QPvnNoGEJNpUUeOgeIwtbM0610tb19v0oa7FPG7Pfj5PqDn7FnIgGqPcD2IJSljK1X1Tejsna/ZXix4Rz+VEsa2zDRtkdmMeP928y0LxjHu6KenENnayOc4HgGb1PjyK4XzEIoVuNZ6YWH23VJmpghSKD/4doWwkjy3FBfwVbFRdFDBU9zp7ULdIIQgsi4Fgcf/KKAPOUBA9uLf6IvCB7Nq0d23jXNtPWZzl0c9Wj0tE0nHpic/aifLsJ/1ua/7KoHZGiCbN6p+T35DMzeughk6Tm+Ja3127f/hu102tGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aZsb3Sgk002WiNUO/5VfWEFxRjuTBo8NxC/mQUVISc=;
 b=JHczsrxt6CRs5Iii2qeGhFDJKc0G8ZA4KRi+0MF/dwnmNA+umSkQfdjTaSL+t+sxs1MgpAArkLIzcqTPUGMemZrEBMt9j+Z1PqwtrPfrkWwY6neJ2T4h4KeSwfO8wcprMZOq/o65L9y8zgQqW11urIUiORKwuOREcduPPpoNJt6NOyiwNaBbWRcH/D2x/S/Xf4JMJaIMjuy5auP9mVCGGjN4/HI3pplv9MPl+bSiukAXVZmvjFBleJqTIOQzR1NEhhw4nIBSea5r2DdP9nu8as0yW8QpNGX98tWXqtvBXBXTje0I0XHPgTy8O+i+Cheqih+8jGWAJMLqPiuzJyAUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aZsb3Sgk002WiNUO/5VfWEFxRjuTBo8NxC/mQUVISc=;
 b=XpbvSLe9uLkLv1eNPhObB/KVR+5c8YUGBMmQJjyT6FqyKzDrXzJH46RDvbtOQw0kCWxJzMSfHLTuKztYfm3gOGp6PA4GYj5pXMCywkJ8Z53d7ZUMGE5QbfotEjqDkpVP5L7tsaVwei+Ap9nrzrHdxsjuraZZBdZiFKjX/xUjrQA=
Received: from SN6PR11MB3088.namprd11.prod.outlook.com (2603:10b6:805:ce::22)
 by CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 04:53:55 +0000
Received: from SN6PR11MB3088.namprd11.prod.outlook.com
 ([fe80::c8d8:e933:bcdd:899e]) by SN6PR11MB3088.namprd11.prod.outlook.com
 ([fe80::c8d8:e933:bcdd:899e%5]) with mapi id 15.20.6043.036; Thu, 2 Feb 2023
 04:53:55 +0000
From:   "Serge Hallyn (shallyn)" <shallyn@cisco.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
CC:     "casey.schaufler@intel.com" <casey.schaufler@intel.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "penguin-kernel@i-love.sakura.ne.jp" 
        <penguin-kernel@i-love.sakura.ne.jp>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "mic@digikod.net" <mic@digikod.net>
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self
 attributes
Thread-Topic: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self
 attributes
Thread-Index: AQHZNsJanW+Rtbwnek2OChi5cl29Sg==
Date:   Thu, 2 Feb 2023 04:53:54 +0000
Message-ID: <Y9tB4PAzizLOV+li@jerom>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-5-casey@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3088:EE_|CH3PR11MB7676:EE_
x-ms-office365-filtering-correlation-id: 49e25cf4-32c8-4a91-7883-08db04d97ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjzD2HY07kS8/8Rqr4BJu0hwQbH1IHHBTaCjCamZDPQGybB6/tf7+VfU2mrJzWKGsKACsNJ2nbIPbCsyqN3RSpW1CgC/NkXRRrNq2YOqX/bg4ejtRZ8Y5qCwnjYtxowP1YcDEmmjB9rpE5OzDNX7Uo6F47VNv68MWToY7a8YOy1omtrGyyNgFfr2A7MUrL9xfwNV/E+2u/4hKECnBomf5kwy+DyiUu21h4WfASBAmH7wPTfJ3QjaWkLqYEZmI2qPf1qnEca/idQKvEAyogmJxNz1xb8ASQEMPslVKot8ku1osO6mUDsc2fLdYgYEGEtHeAKwuzTVd+n0oGI6BF0jnBmsbZage3CEKAZUeRUiD1O6GWL9pegupxTyTNiy9C1WPwWHaTou30lbHtZI3g389T2dHuS+XEQVcFpxG82Obk1z3dy5u8SM8MJHP8MQg3gzZvYADSgOD1mM3kj69Ja/QGTx/Ns7AonmniNenJ7JWPZB1MaVjKh2HxmmACANRyu8OSO6U2gUfArK9X+GHEexikSd5/IaiJ42xxE9xh9vm+NIDJIIUU34R85MfLAtVTV24r2OsTRnC1gHFtTiK10aV1+pmXL0+g3MzVr1cfAICwFGviTJ961sbCxtAmExlJj73/U7oczSByw6CP3XExJKZO9gXKn+AoA5HCCvNN84XhHuRmeCQTnJXv7s+ktWWndLHrpE5jAchzdg0fhuwVTyeyvWqvYsCj7F6nwa7nJgLyk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3088.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(9686003)(6512007)(186003)(26005)(6486002)(6506007)(2906002)(122000001)(76116006)(64756008)(8676002)(66946007)(66476007)(6916009)(66556008)(66446008)(7416002)(4326008)(54906003)(478600001)(33716001)(38100700002)(316002)(41300700001)(38070700005)(86362001)(5660300002)(83380400001)(8936002)(71200400001)(67856001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V3jndQDT3xZSxLHVuA0OE3BxqKp0gQ6UjjpeacMiMRtRtVQvyn8P2Bep34kW?=
 =?us-ascii?Q?YgndR9/XZsomv9K6zr733wNlTrf28ghru640UigCRwx+4rANbIImbFtrt0k3?=
 =?us-ascii?Q?uQHTNnaig39XQfoF+LbZOlUgeSMvqGKxW6Uhkx/UeKbXg8EyOdldY4IQgpW6?=
 =?us-ascii?Q?VunaqvlMv6cfPrcm6lKQnOLkDjGw9xRLh2XFIhU85EwtqSBy28J6NR1CWraU?=
 =?us-ascii?Q?ZAhEooLHDlKXaitqFM+gwrfXBsilTiBr8A3NsSYCbwnCsf9sgZe56CkqQzeZ?=
 =?us-ascii?Q?9up3iS5TzC67HoQwc0Xf+Vj8XMwHEchEuth9BX/nintoNafWTBAMVAJCEBC0?=
 =?us-ascii?Q?iFBrOcURbTzoY/stBFOR5yFQyx4JgnoaNFmdDUDkokTmLHz9Lf/q2HhsDU7R?=
 =?us-ascii?Q?g3Olc3FuGeLK+/ZUPYBs2E8zlRvHDLdvmhhPaWOsjVsPXwx+Uqg7C6b3wkOp?=
 =?us-ascii?Q?ArRWNhZt68g+dcpjlXnZ9PfTijYzolJgpsumWeuNjIWTFJ3HYLwBZkXvdCmL?=
 =?us-ascii?Q?NDTSDTwirciNN90kDpsGWW+OgqRzU/Oh9UfnjcpV1E2rONpWXHLfo3bBgn07?=
 =?us-ascii?Q?bVXcUMFcuZQ8JgOPQyRRdBNXGQxHal0aDIyXrK5BKY/mlwx7TjfR7mPuI9ng?=
 =?us-ascii?Q?QMLcaKjfGY9C5Pd5bBIGh/NwS/tKiVO0Hb6hLjSfX6ldPyntB91Gm1Ybo2CX?=
 =?us-ascii?Q?RQH4IKgOCyXzxvojcc6xnjg7LTZXDxVfrFxxCfsto06QF6ZfNkCy0AoL7u0i?=
 =?us-ascii?Q?ZUouzdZBkkvmwo42cJ0oH9PCJT68HWGDVQ3YKwpEr/VXJ4UGVhFTxm7xgwtY?=
 =?us-ascii?Q?NJ5+92b2qEoHoFuZW4jnM15CL0xKQfdZRK7UFBsku221anbF6diS366U3Fi3?=
 =?us-ascii?Q?zzVPNMB3e2MFvB4AfcQaNQ7C98voTzQwNnehi58gpnC2oz6EwTdfzOwfthH/?=
 =?us-ascii?Q?BHV/HZY5cKx1OvSNTnEbu64BDtNIQT0+wKlrpd2tk0XjOezxufmjrUYxAZ9R?=
 =?us-ascii?Q?VlHlQgCJ6iRbaKe537HroJUAZZCFC/ySFZbWYtDgtJCjYCCakJwaScuKWWMZ?=
 =?us-ascii?Q?XQe3so1uv6ygTspFyID7GIOnv/sxhJvGBbxe75pAuoE1nrYE0vrIF/bZMEIT?=
 =?us-ascii?Q?8KoBMX2eWhUsrq3K46kUUPtblDENf5fUp9AOtG2Ycpe/0X9CfqoO6ZGDwnlN?=
 =?us-ascii?Q?NetHg6GvOQAvrg2AA09cAzP6ZioP/5IuqFeqnlbh9ptMEbe1vLcjHs1D2Jk5?=
 =?us-ascii?Q?6WEqaFvJ3LllnnaJ3quMX70WrgEiSQR8n/S0XR2pM1kVNvEUZajw9Lu1cg9m?=
 =?us-ascii?Q?XaSELiQCrOYsuMKy3S1voU3vjt0PcBt5/MJm2o1d6zqBhsPy73jG6X91ddrF?=
 =?us-ascii?Q?/az8vDqqQUhWJ9uFJ+xRdLk3XEm8RAsRtxsynjIYmF/HZYfCzTwFDRxdfXQD?=
 =?us-ascii?Q?rJP5sKS7wAYNEA98K8Q0he8k0GY6Z8PQbrMpDLJ8oHYTohS2y/sVO7qXwXYk?=
 =?us-ascii?Q?vxCuP+8nSxjk9nqsObcpmf9+IieWYISHT+91BBEEE84qr6Xi/xqzMMQrufCk?=
 =?us-ascii?Q?M9OEwe1pdxi8E1y3KUDVz+IpiPiNjpaqeFvkmNbb?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15DB0979BC23B3428022EE35315832D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3088.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e25cf4-32c8-4a91-7883-08db04d97ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 04:53:54.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBfiUjz9BNYOqXjor2n4D6rCZNiaEcOEyeleYrR+LJGduaD6za9U0asID4pB0Kpmackrq9TksmgK2LvhutydqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.135.121, xfe-aln-001.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:07:13AM -0800, Casey Schaufler wrote:
> +/**
> + * sys_lsm_get_self_attr - Return current task's security module attribu=
tes
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: which attribute to return
> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned. If @size is
> + * insufficient to contain the return data -E2BIG is returned and

Technicality: You say -E2BIG, which is -7, but in fact belog you return
-ERANGE, which is -34.

> + * @size is set to the minimum required size. In all other cases
> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_get_self_attr,
> +		struct lsm_ctx __user *, ctx,
> +		size_t __user *, size,
> +		u32, flags)
> +{
> +	int i;
> +	int rc =3D 0;
> +	int len;
> +	int attr;
> +	int count =3D 0;
> +	void *curr;
> +	char *cp;
> +	char *np;
> +	char **interum_ctx;
> +	size_t total_size =3D 0;
> +	struct lsm_ctx *ip;
> +	struct lsm_ctx *interum;
> +	struct lsm_ctx *final =3D NULL;
> +
> +	attr =3D attr_used_index(flags);
> +	if (attr < 0)
> +		return attr;
> +
> +	interum =3D kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
> +			  sizeof(*interum), GFP_KERNEL);
> +	if (interum =3D=3D NULL)
> +		return -ENOMEM;
> +	ip =3D interum;
> +
> +	interum_ctx =3D kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
> +			      sizeof(*interum_ctx), GFP_KERNEL);
> +	if (interum_ctx =3D=3D NULL) {
> +		kfree(interum);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < lsm_active_cnt; i++) {
> +		if ((lsm_idlist[i]->attrs_used &
> +		     lsm_attr_names[attr].attrs_used) =3D=3D 0)
> +			continue;
> +
> +		len =3D security_getprocattr(current, lsm_idlist[i]->id,
> +					   lsm_attr_names[attr].name,
> +					   &cp);
> +		if (len <=3D 0)
> +			continue;
> +
> +		ip->id =3D lsm_idlist[i]->id;
> +		ip->flags =3D lsm_attr_names[attr].attrs_used;
> +		interum_ctx[count] =3D cp;
> +
> +		/*
> +		 * A security module that returns a binary attribute
> +		 * will need to identify itself to prevent string
> +		 * processing.
> +		 *
> +		 * At least one security module adds a \n at the
> +		 * end of a context to make it look nicer. Change
> +		 * that to a \0 so that user space doesn't have to
> +		 * work around it.
> +		 *
> +		 * Security modules have been inconsistent about
> +		 * including the \0 terminator in the size. If it's
> +		 * not there make space for it.
> +		 *
> +		 * The length returned will reflect the length of
> +		 * the string provided by the security module, which
> +		 * may not match what getprocattr returned.
> +		 */
> +		np =3D strnchr(cp, len, '\n');
> +		if (np !=3D NULL)
> +			*np =3D '\0';
> +		ip->ctx_len =3D strnlen(cp, len) + 1;
> +		total_size +=3D sizeof(*interum) + ip->ctx_len;
> +		ip++;
> +		count++;
> +	}
> +
> +	if (count =3D=3D 0)
> +		goto free_out;
> +
> +	final =3D kzalloc(total_size, GFP_KERNEL);
> +	if (final =3D=3D NULL) {
> +		rc =3D -ENOMEM;
> +		goto free_out;
> +	}
> +
> +	curr =3D final;
> +	ip =3D interum;
> +	for (i =3D 0; i < count; i++) {
> +		memcpy(curr, ip, sizeof(*interum));
> +		curr +=3D sizeof(*interum);
> +		if (ip->ctx_len > 1)
> +			memcpy(curr, interum_ctx[i], ip->ctx_len - 1);
> +		curr +=3D ip->ctx_len;
> +		ip++;
> +	}
> +
> +	if (get_user(len, size)) {
> +		rc =3D -EFAULT;
> +		goto free_out;
> +	}
> +	if (total_size > len) {
> +		rc =3D -ERANGE;
> +		if (put_user(total_size, size) !=3D 0)
> +			rc =3D -EFAULT;
> +		goto free_out;
> +	}
> +	if (copy_to_user(ctx, final, total_size) !=3D 0 ||
> +	    put_user(total_size, size) !=3D 0)
> +		rc =3D -EFAULT;
> +	else
> +		rc =3D count;
> +
> +free_out:
> +	for (i =3D 0; i < count; i++)
> +		kfree(interum_ctx[i]);
> +	kfree(interum_ctx);
> +	kfree(interum);
> +	kfree(final);
> +	return rc;
> +}
> --=20
> 2.39.0
> =
