Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC56DB019
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDGQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjDGQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:04:43 -0400
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C784B8;
        Fri,  7 Apr 2023 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=409; q=dns/txt; s=iport;
  t=1680883474; x=1682093074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZvPldDBpkvNt/0abGqrqQoag1IHAQQNn5qS8F705+is=;
  b=lbTiPbUF+eyTRDeOo1crFo1z48ey5gcANefSD/0KBSkWQdod2vr0V+ZD
   KiEWLYpzqrllJeX1Ivp3AbI8+uiJxJBWMJiVFAASevKGWEJ804Uu1ruL6
   iOBbSSzHv742iqwZDWm9Av6oZYN1Ghl+fyNn1ZgSSGYjbYxj9wkAhTU23
   s=;
X-IPAS-Result: =?us-ascii?q?A0BEAwBSPjBkmIsNJK1aHQEBAQEJARIBBQUBQIFPgVxSc?=
 =?us-ascii?q?1s7RogeA4UuiDOSIIoRglEDVg8BAQENAQFEBAEBgVIBgzMChTwCJTgTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhgQBA?=
 =?us-ascii?q?QEDEigGAQE3AQ8CAQgYHhAyJQIEDieCXIJdAwGfQQGBPwKKIHiBNIEBgggBA?=
 =?us-ascii?q?QYEBJ8iCRaBK5E6JxuBSUSBFYE8gW4+gmICgWCEFIIMIpozCoE0doEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4EQCGqBeUACDWQLDm+BSoMqBAIULDcDRB1AAws7Oj81FCAGWIEZJ?=
 =?us-ascii?q?AUDCxUqRwQIOAYcNBECCA8SDwYmRA5CNzQTBlwBKQsOEQNPgUYEL4FcBgEmJ?=
 =?us-ascii?q?J9DxwsKg32gbU0Tg1cBpVeXc6d2AgQCBAUCDgEBBoF6I4FbcBWDIlIZD44gG?=
 =?us-ascii?q?YNZj3l1PQIHCwEBAwmLRQEB?=
IronPort-PHdr: A9a23:JD2j5hSHi0qGy6XQ4Kwd83dl4Npso7vLVj580XJvo75Nc6H2+ZPkM
 QSf4Ph2l1bGUM3d7O4MkOvZta3sGAliqZaMuXwPatpAAhkCj8hFkwkpGsXQD0r9IbbjZDA7G
 8IXUlhj8jm7PEFZFdy4aUfVpyi57CUZHVP0Mg8mTtk=
IronPort-Data: A9a23:CNKzlKmM+qanUMIt9GRfeh7o5gwMJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXUTyFaP2JY2CmLoxzb4zi8UIC7JGBy9Y1TAFprS42FFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgFWeIdA970Ug4w7Jh3dYy6TSEK1rlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW6
 Ar05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkSvqkAqm8A87ko0HPEBM0pPjie4o9Iy5
 slvvI6fdhoRF7KZzYzxUzEAe81/FaRC/LmCKn+lvInNiUbHaHDrhf5pCSnaP6VBpb0xWj8Ir
 KdecWtcBvyAr7reLLaTRuBqh8knM8DDN4IEsXYmxjbcZRojacGZHPuSuYQJtNs2rp9eTK7sd
 8ooUjx+VC3aUg1lCHsSLp1ryY9EgVGmI2EH9zp5v5Ef52nV0Rw007X3NtfRUsKFSN8TnUuCo
 G/CuWPjDXkyONGByDGI7mihi8fRki7hHoEfDru18rhtmlL77m8JGgwNR0e8r7+6jVy6XM1EK
 E1X9jYGqak0/VasCN7nUHWQrGGNuh0RQfJeEuM9uVDLwa3Riy6DAWIEDTJdQN8rrsk7QXotz
 FDht9DzFy10oqGSRzSe8aWQqiypOik9KW4EbDUDCwwf7LHeTJobhxbLSJNoF7S4y4OzEjDry
 DfMpy8771kOsSIV/66mp13fhiCdmpqKYBIX7xf4YX+dxxwsMeZJeLeUwVTc6P9BKqOQQV+Ao
 GUIlqCiAAYmUMnleMulHb1lIV252xqWGGaG0QMzQ/HN4xzoqiD+LNEIiN1rDBoxWvvobwMFd
 6M6Vel5y5ZJOHKsYcebiKruVpx2lsAM+TkZP804g/JHZpx3MQSA5iwrOwib3nvmlw4nlqRX1
 XannSSEUy5y5UdPlWXeqwIhPVkDnXxWKYT7Hs2T8vhf+eDCDEN5sJ9cWLd0Usg37bmfvCLe+
 MtFOs2Bxn13CbOuOnmPrN5IdwpQcRDX4KwaTeQKKYZvxSI7Rgkc5wP5mtvNhqQ8xf0Oz7eUl
 p1Dch4BlDITekEr2S3TOiw8N9sDrL50rGkwOmQ3LE201n04CbtDH49BH6bbiYIPrbQ5pdYtF
 qFtU5zZXpxnFG+dkxxDNsaVkWCXXEnx7e54F3D7MGFXkl8Jb1Ghx+IIiSO2pXZWUXTn6ZJny
 1BivyuCKac+q81ZJJ6+QJqSI5mZ5hDxRMoas5P0H+Ru
IronPort-HdrOrdr: A9a23:WNZ5/KM+sPkAcMBcT2D155DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8MjzjSWE9Ar4WBkb6LS90DHpewKSyXcH2/hvAV7EZniphILIFvAv0WKG+Vzd8kLFh5ZgPM
 tbAspD4ZjLfCVHZKXBkUiF+rQbsaK6GcmT7I+0pRoMPGJXguNbnn1E422gYypLrXx9dOME/e
 2nl6x6TlSbCBEqh+2Adwg4dtmGg+eOuIPtYBYACRJiwhKJlymU5LnzFAXd9gsCUhtUqI1SsV
 Ttokjc3OGOovu7whjT2yv49JJNgubszdNFGYilltUVEDPxkQylDb4RGIFq/QpF4t1H2mxa1O
 UkkC1QePibLEmhOF1dlCGdnjUIFgxeskMKh2Xo2UcL6vaJOg7SQ/Ax9b6xNCGpsHbJeLpHof
 92N6XzjesMMfqIplWP2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZKIMvW0vFvLA
 BVNrCV2N9GNVeBK3zJtGhmx9KhGnw1AxedW0AH/siYySJfknx1x1YRgJV3pAZMyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZV7nCKYEMXTQrIOf2sR+2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmIZG9xjcKV/NKwgFCvsukKSRloeMMIYDaxfzOmzGu/HQ1skiPg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,327,1673913600"; 
   d="scan'208";a="92760439"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Apr 2023 16:04:33 +0000
Received: from mail.cisco.com (xfe-rcd-004.cisco.com [173.37.227.252])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 337G4UHw028029
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Apr 2023 16:04:33 GMT
Received: from xfe-rtp-003.cisco.com (64.101.210.233) by xfe-rcd-004.cisco.com
 (173.37.227.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 7 Apr
 2023 11:04:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (64.101.32.56) by
 xfe-rtp-003.cisco.com (64.101.210.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Fri, 7 Apr 2023 12:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgeMFuXoV0wPu3+M6SmIcvTZFtze+PmamZXPgmy3rV6o2OBV7GDb4E3oVczJ4gWn7JQrsj1BElcZ+mMcWT1QVhfYxW1uCewR+cBb9/QU4+QEdPd5n4ct3d2zBlnRHp3zgWTdAs3lSYz+PQJEcxcIYv/jUoz22SuT4pNZMkR/8zo6mRmAwLew4qVuxEpa6OVCS2HeavsENKTVGrjluBJ2J6LoJ2oostFl7tgrtbyblKLFb91htMV/k0w3ciHK/axl071bYb92WC5aq08I+XlN2wrzmzZknUY10CAVZyIj+CR4cZxzFgQ7Did3tkjtOpHGUOAR2H5QWusJt4f1mF29Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvPldDBpkvNt/0abGqrqQoag1IHAQQNn5qS8F705+is=;
 b=nN+QmDDqIX+oXRrcE2wBklwrWdv+92MGbmu5EKFXQ3bvojHRgfSZQb76exnBdacq5s+8JdOylZl1+3N0k22jgatNLCDSBb6YS86N96qPw3zlPoGYXi5mZvs6a8Vh6eC6qsnfzIq15ybqM3fAJAhYiraWYogsTTg1auS5Xpt1sGQESdVA0Kiyk9M2BGtwEfiGAby8Oqu954i+gUxewz4B3q2cVoiOyuFeKO2hbqO9WLoO9C+jf7KYmDEFh0Vp4B9osVX1ozeQaRgfEf2zRmEk6dFsjf/gQiaA3IAg7bJ600VxxaSHJHF7FttLR/+xc8bg2qPIJREc2U23YUmR9va0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvPldDBpkvNt/0abGqrqQoag1IHAQQNn5qS8F705+is=;
 b=ALCemW4aS3nOtuKXsfk5114hZqpPwdPB2An2l0EvAktX3a+ezF6Zy9TSC+ycegg6ETz5LdGtJKP0RXWjaJS12W1dCmCsN9KLRWpmLOA91jIuyG0s6xeXGPPhwoxF0fPtSbx/bDIgTa0iWGkyb16ERAHWLNtRS72x0rhftR5KPNI=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by BL1PR11MB5510.namprd11.prod.outlook.com (2603:10b6:208:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 16:04:14 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 16:04:13 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Topic: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Index: AQHZaWqYW/PiGCKJbkGjA/VaWrFw5w==
Date:   Fri, 7 Apr 2023 16:04:13 +0000
Message-ID: <20230407160413.GD1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
In-Reply-To: <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|BL1PR11MB5510:EE_
x-ms-office365-filtering-correlation-id: efcca194-05ed-46a8-9392-08db3781bb3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RukIpmNFFeDnsYn+ZBQDB1zi6aUMuu3gGkeceFs0WJszYS4pG8PJ8dbJDA0y3/XM8bNSqkepcbgyJwsztvZy4CjlsuOZL9p9uu+VAH0fYu/IV8Va6pXModDFV9powlAjZtjpqpZ+pkz+otxSm2GMJnJVZ/gPWnLrMn7u/27QimmPXlXczMw194lmqm9NQIZwVmneSMjWT04gD96E1Doi+lWXMRwD5Zkmuhvs/veqARpFMSdh1I3UI8PrIr1dNxrZDzy14uSTOkrSvfed0/67lsEOorwsP2XD5suMC5cV9z1ZC3RaaUcKqrXi33ifHS22xgniGYOn0izOI6k50a/zBYAMf1xnS2NhqbtgyDIq/ucXRdUM2L1PTuU23WIFehb9wjl7o0L2fxYuRodUWyRsOD8USNGQoNfO/xB1uYkD+6J9+mrPKiStHlGgRczvAyG9/s/fBffyOw0zZ1Ek1brA7ha9KGp38z4S72+VpTqGXvD+hAI7PWNwTtuHlsF5r3qv7OOPWiYS3CVlQn9WbOb/OaMB045fpU4pHMX79YNpmET3KNnRQ5OgJdSBvyo7jkDfA4ix9UXyxLwZkJqU7PYEI0LIOoYY7/kKMj6U+b/tX+MvnpikpMvtmEpO8NBLTIAB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(54906003)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(316002)(76116006)(4326008)(6916009)(6486002)(71200400001)(41300700001)(8936002)(5660300002)(4744005)(2906002)(26005)(186003)(6506007)(6512007)(9686003)(1076003)(478600001)(122000001)(38100700002)(33716001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yY5yLk3iidXPKKkMLJG6yAJkhGfYbXZN1NetsdOxEXgbX6SYL4Lc+C9oVsRL?=
 =?us-ascii?Q?1YrdN9GUVtcyNuuazb6dRUe1+mbN8m2PvhJK/35Ny2/r3/ldtQ3+yfJg7i/3?=
 =?us-ascii?Q?4XR4JA85jomK09O+G3aB7HVT8+b2il8e5oGfmQdWDvvvSc1A7u3PIUPskFLF?=
 =?us-ascii?Q?Li91VjGR2pBzZc0yyaqQJ2j9Z6F9vaMKMcXDh5Ibl6pEQn8cytcoerviaJX4?=
 =?us-ascii?Q?79GbqezVe65NDXkp2QJiRonoPyz1KDTBThdyY6TYNYNuyiX8kJLT9J1UH5lt?=
 =?us-ascii?Q?jaKjwagtbB6FJly4CqdVhVlNwDa2AaHCBrIMkuZbS8NX1jjyiVZY7Jm0DG5I?=
 =?us-ascii?Q?9R2KyVGF/0Vyn0xziy9I0YOfBGBjTkmczNJUfzMiivsQvG04Kp0mK73g9D2Z?=
 =?us-ascii?Q?GtXFCWND4V+if1MDgn/60U7YrDvAesEtHRCjd+bP4riSNji1mvSfXXYItZM/?=
 =?us-ascii?Q?sJOAR2fq6V7ZVscNVO0LdwACxW5NNgCVA/p+Dy749m6xKIDT2EA/LANRvf2Q?=
 =?us-ascii?Q?kCrQ2VqP4TyLKNClGBDkBz9YHcm2Gwwvd7V1ZhaXJMrkFr42x6heE9HrTnFx?=
 =?us-ascii?Q?2Mjkv9JYZtkN1KpMk/83b7/oB9/4zUHpF8kwhYr61RA0Sy2OcQs+236ZmCQF?=
 =?us-ascii?Q?8Uwc13Q/WewRZTNdHC07sYc4dzxzxpA0/GkEVlQ2EsrBWD/kJDII5HrMKtgo?=
 =?us-ascii?Q?J04IWa+A5Y8xkbbWbT4LaNumdtLOn8PRpMtAzpaWBpwxqi1c78Z7fLC+9Twh?=
 =?us-ascii?Q?5gI/yhugk7NbgVaF5hn+nEzAvqzgX8g49JF+AxJeJXglhId3gsw6iC+O05Ep?=
 =?us-ascii?Q?h/lOi+7XVvbEfwGuBJBJqCijDwFhrkQglAwQYM3RID7zfuJ4YkWVfrdaulP8?=
 =?us-ascii?Q?ADCu0jYnWR0ZbuOD7oT+oPpLmjuQf0eO/I4AKR6nT1NNHqkaljNiuQj1KIfV?=
 =?us-ascii?Q?fe7gkvWg2G9C+cxr9hoU0aJ5/0eqxn1tvXzBus21s5LCdA/IfaN39O16j5HP?=
 =?us-ascii?Q?BYvXCqTTt1T3tHcAeEwgce6FDWvD4MH03t0+UBplSxR18xI9WdotP2xv6807?=
 =?us-ascii?Q?/4oERTL44tf+yRw1dPNM9NRlNbhaPX7fQj6ip6HIqC39xsJRYF5+jUYCr/Cb?=
 =?us-ascii?Q?/K62WwEWieAKTQksFD9eddKPRTC+0ItH2ygJpcDyUjq15O9loNdWI/bqkCEr?=
 =?us-ascii?Q?MrWrTkr4/3piqfroQyyPKmX6x+wzMOGybqgxiIaSxrxczhph68rLZleBfCh6?=
 =?us-ascii?Q?E7KGbjPehNMRjEcKKprl9ax7UVBnldA6OBOzDEApVtxWCRqsrc5PSSnxWONj?=
 =?us-ascii?Q?ugc4mZEEMGZljvH+lPUDuTASr248aj1Pk5J2xIz4kD93RhhObyQLdl3jCejJ?=
 =?us-ascii?Q?hFNT4wxZuBbRJy3hAolpV93M9EY5xPIlDDO0R1GaSKj3mqT6A0keoCIbZNKt?=
 =?us-ascii?Q?krP+ss6BBxZTc3nUTv/eZPsmCSV64ZYgN+nREepf/R689PchTh+TyQN/upps?=
 =?us-ascii?Q?ItPd+saCfvAuc2A1EQUaKkQ+K3YpCrW6qknK5kinaj2ERldVJYdIXyWBmksB?=
 =?us-ascii?Q?mMn/Yzrj9VwzCgoFWqKEEmyJTGKzfVoNfbXjyFiuKzg/j8XpWPd52XRoz35W?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <758C688D0A6D2E489A51151849D79ABD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcca194-05ed-46a8-9392-08db3781bb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 16:04:13.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7agnWa80esOD1q1nWLdu6Ltxmbw7lEHzj2wqQM45bQg3lHjFOgy6HpVNJe4xpX2uaGHWDuoYyioYcPUzFwljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5510
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.252, xfe-rcd-004.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
> > @@ -0,0 +1,27 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
>=20
> Dual license.
>=20

What are my choices here? I see this,

# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Which appears to be what your suggesting. I also see this,

# SPDX-License-Identifier: GPL-2.0

I'd rather use the later.

Daniel=
