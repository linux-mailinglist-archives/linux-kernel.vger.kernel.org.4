Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA46DFC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjDLRC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDLRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:02:14 -0400
Received: from aer-iport-8.cisco.com (aer-iport-8.cisco.com [173.38.203.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4ED93E4;
        Wed, 12 Apr 2023 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8234; q=dns/txt; s=iport;
  t=1681318906; x=1682528506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rwuHPOEJ+oGD6YkVD54ITwZZwA3LUhLMSAksQgrUy2M=;
  b=LM/PT9UJv75eacbIlcem4pAzNtl9/R5XZoTNT9Xxjw3Ts9Wa+NbITSVT
   IZzMy6hublKbVZ4zYkBycbJSY9kOk1DeeD5A2bcNHRWtP16jK4u+eWs/j
   SZMfm5LrMe7LJbuV0ouUznYU88j4SbRVPTyJjHspkvtlpkuatIM/a/DWu
   U=;
X-IPAS-Result: =?us-ascii?q?A0CpAACW4jZklxbLJq1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgSqBXFJzAlkpEkaIHgOFLogwA4tLhlWLUIERA1YPAQEBDQEBOwkEA?=
 =?us-ascii?q?QGFBgKFPSY4EwECAgIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBA?=
 =?us-ascii?q?QE3BRA1hWgNhgQBAQEDEigGAQE3AQ8CAQgUBB4QIRElAgQOBSKCXAGCKAMxA?=
 =?us-ascii?q?wEPBqAJAYE/AoogeIE0gQGCCAEBBgQFgTcBmxUNgkcDBhaBK4dHiXNCgUlEg?=
 =?us-ascii?q?RWBPIFvPoIgQgKBIz2GICKBDJBliFgKgTR2gSAOgTyBBAIJAhFrgRAIaoF5Q?=
 =?us-ascii?q?AINZAsOb4FJgyoEAhRQNwNEHUADC3A/NRQgBliBGSQFAwsVKkcECDgGGzQRA?=
 =?us-ascii?q?ggPEg8GJkQOQjczEwZcASkLDhEDUIFHBC+BXQYBJiSefAcxDgEjJgUBBwIcB?=
 =?us-ascii?q?iAwQQgsCDcBDwtYA5ITsDhvCoN+i3KPDoJngwZNE6kvlR2CVo1Tg26WNQIEA?=
 =?us-ascii?q?gQFAg4BAQaBeiOBW3AVgyITPxkPjiAMDQmDUIUUimV1AgEBOQIHCwEBAwmLR?=
 =?us-ascii?q?QEB?=
IronPort-PHdr: A9a23:71oZyBfjUHWP7SUVRgj8LQeKlGM/foqcDmcuAtIPgr9UN6O78IunZ
 QrU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+YgBOAMirX1TJuTWp6CIKXBD2NA57POPwT4LbicW60/+705bSeA5PwjG6ZOA6I
 BC/tw6ErsANmsMiMvMo1xLTq31UeuJbjW9pPgeVmBDxp4+8qZVi6C9X/fkm8qZ9
IronPort-Data: A9a23:b0xGSKzJmFmgsQPVLZN6t+cgxirEfRIJ4+MujC+fZmUNrF6WrkVVm
 mMaCGmAPP2PYmD1et0gbIWy9RwF6MXRzINrS1dur1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJloCCea/H9BC5C5xZVG/fngqoHUVaiVakideSc+EH160U46wbZi6mJVqYHR7z2l6
 IuaT/L3YDdJ6xYsWo7Dw/vewP/HlK2aVAIw5jTSV9gS1LPtvyV94KYkGE2EByCQrr+4sQKNb
 72rILmRpgs19vq2Yz+vuu6TnkYiGtY+MeUS45Zbc/DKv/RMmsA9+vpiGqUiamJ5sSeug/Ah6
 ot2uI6RSxh8a8UgmMxFO/VZOyhzJ+hN/6XKZCn5us2IxEqAeHzpqxlsJBhpZstDqqAtWToIr
 6ZwxDMlNnhvg8q6ybS6R+1zj+woLdLgO8UUvXQIITTxUax5EMiaG80m4/dF4BM23ZtiFsz1X
 OsTWQMwaE7sTw9mbwJ/5JUWxbf02SaXnydjgFaUo7cnpmve1gp81JDzP9fPPN+HX8NYmgCfv
 G2u12j0HBAROcCFxDet7H2hnKnMkDn9VYZUE6e3nsOGm3Way3ZWCQURT0f+p/ClzEW/QNlYb
 UcT/0LCsJTe6mT3F/eiYR6djkSWmQI8C/gOKOAoyQOSn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLhoz8PLWEw2FFyYS/Fnop4vQ9eKgBIdTdfNXNsoR8tuoiy+91p5v7aZo87SPbdszHjJd3n6
 wiuxMTUr5YJhM0MyM1XFnic2nf0/sihouIdwgjMRW+/pjt+YIeja+SVBbnnARRocd/xorqp5
 SZsdy2iAAYmVsDleMulGrxlIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGG5O
 RWI5lMKucQNZBNGiJObharvU6zGKoC9SrzYugz8NbKin7AoLlbcpXEyDaJu9zGxySDAbp3Ty
 b/CIZrzUh72+IxszSG9QK8GwKQ3yyUlrV4/trilpylLJYG2PSbPIZ9caQPmRrlgvMu5TPD9r
 o832z2ikE4EDoUTo0D/rOYuELz9BSViVcCs85cJKoZu4GNOQQkcNhMY+pt4E6RNlKVOneCO9
 Xa4MnK0AnKm7ZEbAW1mskxeVY4=
IronPort-HdrOrdr: A9a23:AbRULK2NU8VSt+qMmp+dAgqjBRtyeYIsimQD101hICG9Lfb5qy
 n+ppUmPEHP5gr5AEtQ5+xoWJPtfZvdnaQFh7X4pd+ZLUfbURiTXfBfBOzZsnzd8kzFh6FgPM
 JbAstD4bLLfCJHZKrBkW2F+pMbsaa6GcOT9KfjJhVWPHxXgshbhm8TYGvrcDwSeOAFP+tEKH
 P23Ls/m9PUQwVtUi3NPAh8YwGsnaytqHvOW290O/cg0mazpALtzIS/PwmT3x8YXT8K66wl63
 L5nwvw4bjmm+2nyzfHvlWjrah+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyv0lA3i9
 PByi1QevibqkmhOl1dkyGdnTUI4wxeskMKDmXo2UcLlPaJAw7SzfAx3r6xPCGpsXbI9+sMoJ
 6jl1jpxaa/Symw3xjV9pzGUQpnmVGzpmdnmekPj2ZHWY9bc7NJq5cDlXklWqvoMRiKoLzPKt
 MeR/309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw9ArfZv0kso5dY4Ud1J9u
 7EOqNnmPVHSdIXd7t0AKMETdGsAmLATBrQOCaZIEjhFqsAJ3XRwqSHrYkd9aWvYtgF3ZEykJ
 POXBdRsnMzYVvnDYmU0JhC4nn2MSyAtPTWu7djDrRCy8rBreDQQFi+oXgV4r+dn8k=
X-Talos-CUID: 9a23:wNEH8WDiIfhEVt76E3U+2hEqGeULSG/60FeAARGDBHRISqLAHA==
X-Talos-MUID: 9a23:1pDFggV2/Trwx0Dq/CLQoDc5b+tj2Y+VKUo9qMoC4eWoJwUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from aer-iport-nat.cisco.com (HELO aer-core-9.cisco.com) ([173.38.203.22])
  by aer-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Apr 2023 17:01:18 +0000
Received: from aer-opgw-1.cisco.com (aer-opgw-1.cisco.com [173.38.212.133])
        by aer-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 33CH1HDM078314
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 17:01:17 GMT
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by aer-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 17:01:17 +0000
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by aer-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 17:01:17 +0000
Authentication-Results: aer-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="5.98,339,1673913600"; 
   d="scan'";a="75350"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTh9maAJUZ7zojlNmLpA38pBsIMLnDqBj9DpltovfGDr+HHWBX1oW4uT4smjgWJ3SLBFM1muR12rDm7pE4RkxS4ABLxwN/qY3iKwAQkkIPsQZGEInkjPrSxkhPyj274d6URORv2cKW54Pr+2NJkaqa1YAYRUSE1jgslmxU8hMYbe4F8vt6x0jc8Z7uTVYaogF8Z9/fF5czvRofWGJ0YBQbjDdZOD9efRoRp2PWGh3X4JX5K1BzKUgB95QVX/l5JnPK3Tva7MLBN2qhZaqaUCw/M/kuhmeKoeCuD8PbBGLijFNPXSiMVz8/WliDMxjRoFBwCPb3Wp08xnORkCXHwpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpwGRjn1B4a7x8+iq04mq9IeMaUfy6vRmq696Pe8fmE=;
 b=NrdKGn3pZa9ws+JmIMnbzPsb0AP8ubuSa4oo8PW42TePlGoHCURoYBaBKqfjkMR95iEj4vVxW0mr853BouZyAHJcMGM5VZGqmLgZgM5Yj5jVqM41sDVWl4yP3hggHClcQXHUTN0dpsORiGLfJb9NSmN8Ywci7o7hhEXbZwDP1mcVk58GKStUVXfEXCOo/fsCUG4gAF1kay4SvgAF4/IrlaCCacKw5z9b0ivBV3UF2dsBwMm4heaYL/GnikQ77BhRgGEpCgBHZnj+w8iq0HCQgEgOGIkEipwtNavZ78Ga/QVCWm/kzRroS6tUafZ3hWMt8tlNDiuQ+GCp0nU3U4neEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpwGRjn1B4a7x8+iq04mq9IeMaUfy6vRmq696Pe8fmE=;
 b=nCsh1dTwmtjLJ7XXCUsiCbqiAqzJGpUm0ix+UO7i4rUhYQzP5NtGgTWOCKUllJ7dKxQvN3V502GTPn0QitSodcEIi0/rR6Er0ThF6gSIxEmrgBIkpcm/BI4cDmiMmkaCgoiY51PdSx7kGeeEz7pzI+v7uaPNAvhG0M+GGRklOAM=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by DM4PR11MB5438.namprd11.prod.outlook.com (2603:10b6:5:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 17:01:13 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 17:01:12 +0000
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
Date:   Wed, 12 Apr 2023 17:01:12 +0000
Message-ID: <20230412170111.GS1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
 <20230410170915.GE1391488@zorba> <20230410175054.GF1391488@zorba>
 <c1319685-49cc-9326-f4f9-1190ff633450@linaro.org>
 <20230412150452.GQ1391488@zorba>
 <317c09a8-4df3-0a33-62b4-f5a496dfa0ca@linaro.org>
In-Reply-To: <317c09a8-4df3-0a33-62b4-f5a496dfa0ca@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|DM4PR11MB5438:EE_
x-ms-office365-filtering-correlation-id: 83cfe5a5-60e2-4e34-c788-08db3b778562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Srn+4/Wfy0W2dOCDV9kwcElzOFzBdlC4OG7wWv3fNlDUHUDCp+QZr2Hnp1LzTuhSpewDmZwdX8/Ghs+YonBr/U7S4VeZOgt5awNsHrOUUPUN9Kn0KevDQdckozkSLbPrQkHC8caldVIGiSV3ShW7dgT4WocRmwRWKFykLo4EdWRLogXgp9gp551vP/uCc+HeaSH1iWU/1CP2lwwhYVYm/Y3/NVdF6KNkQ+asrmcygioqhSnLhCPvm9tHS0oCWeC1IH48Zi7okv6lza6c0gbp2+xe4ou4qK5BMvLny47LUsi98aoalGYcZAz2Viev6zn79+52PX6LvzZPj+Vs35rz2v9uShqzSucHyboSPfT+o/AYkzytbT19q/rK8sOhSOAP0Xmq1MAtxgkMyiPj/wR82e1twNLGl0Ng9aB6TCMw1q4Ixh6O2o9Qg43nn7wPtj1zMIfxyprnqIZdhkoIZedJ332ROdc2HsLkZhnwO0bkCphG0V4FYZXdCjL70trcyMEaG7PuIh/t4AAi6q01oEvowbj/My3Fig4g514sZepMia3CzYs8OiSk6+f7M1p+sMM71a6rsq/SJiRrG1E8ApKRJbkia/ODhHmuNOtQVOOV6RnMZj5+6Ve2VPkphwZdAaTqkVFGX8GeosIujcmXDfrU2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(33656002)(38070700005)(38100700002)(122000001)(5660300002)(2906002)(316002)(66946007)(8936002)(8676002)(86362001)(6916009)(66446008)(64756008)(41300700001)(66556008)(66476007)(4326008)(966005)(83380400001)(54906003)(76116006)(6506007)(53546011)(186003)(26005)(9686003)(1076003)(6512007)(33716001)(478600001)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?luFt5e5fHqhHNJ1tNq2KMYYcTa4ieg9+XAR6xtD6B9wSvMLVQBnFH6bAsJqC?=
 =?us-ascii?Q?SoucbsQLzbGsW2Hk6mV7RSUswi59UQSpzGE2GEnKCKauPz3CR9nev4LLX2Dz?=
 =?us-ascii?Q?IGCFYcPsZAVlH+6zQBJcTaKWwDtZR8w9s8mtKj+nZtfGX6ckjSKFpGA6apuN?=
 =?us-ascii?Q?oFcaGutaC0x8Nko60Qp7adZdVfFyyv5JDDMX4orCizSkWd49klDPVVYLfvQr?=
 =?us-ascii?Q?zgJqVUvSzEygXAGBWlPyOKa70ImMF9K9S8bFCHC75cviZiyKQqRo3iX5e4Vt?=
 =?us-ascii?Q?zt9zcf46GK4tkyZvHbbdA0Lvqj3xfRJGydnKcsxkRvztcGgvg+RYSNYfMQTl?=
 =?us-ascii?Q?g6B1jQSCDU8IlUi36MXF8Nh4IwaJh7U6wh8QkdEPAwGiNQleynj1e9qUKdCF?=
 =?us-ascii?Q?S2xZVWzQBTNPJ+f5Iql+Ntdbk8L/71pER+VqEggm7bFoXp8dFYNdHf/7pFyw?=
 =?us-ascii?Q?fi72xf+FtIfew49Np8wHSRUpY5exma0QM8kqYns75mJ/ILCFUKahEVV7Ho2W?=
 =?us-ascii?Q?kspmS6lGTfz19Omr6ywyolBMJtG+PaJVPpKm8/M0Ma+1caDzEd9ycEKM9k80?=
 =?us-ascii?Q?VteLyv7rPMwtID1q0NI2FuKiqz6DwsSyNeHYkW4Q3lUTnr/+X+MiPBzNUVfy?=
 =?us-ascii?Q?Cv2Ah/xh+dfyT8jqDRhKLPkddQIbjyXkyXEns2fW+7UVbV3bI/+/S4vFaj1T?=
 =?us-ascii?Q?srxgB8UF3N03OiKUXJaASxty0wSx0Zzq2+4uEUnzJYyFlQ6MY2YCcLR6RFST?=
 =?us-ascii?Q?SmKATrmiZHIT4ACXmUa/glxe+k5drwaK6Z4cJPL6qPsYilhnPEipA62yas/i?=
 =?us-ascii?Q?6OMHxgNKplEMogzU+7sCtJq3lEKwHrG7WcZs+J6MjxdkrL/kjewcPlSnguuo?=
 =?us-ascii?Q?snSaOlwtPoUV146OQGa0VHtwmf7ftP5Cvd2d3tIkbSwfFKqKzG+ZJ93qheno?=
 =?us-ascii?Q?qOISuKWxRBXA4JSZpZi6noELBHt873IuU3WV04FhjeEAcsJecDL9brvV2X98?=
 =?us-ascii?Q?oY3JGEfcnNI2CvIovubPwZ/NMTHUpGftbdg1xZiP7j12jVSV775YWT/Rwe88?=
 =?us-ascii?Q?6JFMGeV1ulbxJRsH8joMwwKSZ0IbTxjwwhVeizFGhVugbNsU2LMk3Vkh8VTk?=
 =?us-ascii?Q?pnatUgMcVTBPkn9AS7hi8kGy0Sw3Fd4fy1USjfmxwA1tI8IbQnBvjbIdNkjL?=
 =?us-ascii?Q?Pfc7pWjNhwPJhTXtOJn4FzwETOVA8iXvRU07m+ExUyT+bsXscjCtAQtZSLdV?=
 =?us-ascii?Q?3KsWzRdd6oLU5Kaj7OHIkVW/GyuFaY3c2KsmGh9IVx6szFhXBM1+kRPNqjCJ?=
 =?us-ascii?Q?6fSGiwGDrqf3ggUEYRE+lwwsnSiGb8hySvRzyf8jncfAHpiurLWx1WJnQ4Gq?=
 =?us-ascii?Q?AuuYH+RQBnr18e4EvyN4g6J2mTfYqzNM1+Gu6g1Q/ErHaMk57ufpi/L70efg?=
 =?us-ascii?Q?5SfG2CHyNO7duToeHet4ciJqa0bQKJTUuf/NUe7sI25cUR8cVKXwIZKdzAaH?=
 =?us-ascii?Q?DWXY1jNsXsOK9dDs6aOnTsbwlQlKLO8nIUHaAAqvsRs3uuiJMzVfm6YG+cIP?=
 =?us-ascii?Q?s08iFYp1Ukm8GVzwB15snvQi4gYixTENlvvqa7gDQSA7Oxi5RfnAo+bh1xVN?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74E55130E5A24543984F5246D1FC8BF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cfe5a5-60e2-4e34-c788-08db3b778562
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 17:01:12.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvhxnDF32+QqnchXc6mKuP3DH/1Ta0Gh2aP0BLTkruUj0xWdbUU84xRLexcLlfUqyUL3WrYQabE0c0jyY+hPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5438
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 06:13:57PM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2023 17:04, Daniel Walker (danielwa) wrote:
> > On Wed, Apr 12, 2023 at 09:24:48AM +0200, Krzysztof Kozlowski wrote:
> >> On 10/04/2023 19:51, Daniel Walker (danielwa) wrote:
> >>> On Mon, Apr 10, 2023 at 05:09:15PM +0000, Daniel Walker (danielwa) wr=
ote:
> >>>> On Mon, Apr 10, 2023 at 05:28:03PM +0200, Krzysztof Kozlowski wrote:
> >>>>> On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
> >>>>>> On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrot=
e:
> >>>>>>>> @@ -0,0 +1,27 @@
> >>>>>>>> +# SPDX-License-Identifier: GPL-2.0-only
> >>>>>>>
> >>>>>>> Dual license.
> >>>>>>>
> >>>>>>
> >>>>>> What are my choices here? I see this,
> >>>>>>
> >>>>>> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>>>
> >>>>> Yes, the one suggested by the checkpatch. Did you run it?
> >>>> =20
> >>>>  I don't recall if I did or not.
> >>>>
> >>>>>>
> >>>>>> Which appears to be what your suggesting. I also see this,
> >>>>>>
> >>>>>> # SPDX-License-Identifier: GPL-2.0
> >>>>>>
> >>>>>> I'd rather use the later.
> >>>>>
> >>>>> Why? Bindings should be licensed under BSD, so what is the reason t=
o
> >>>>> make here exception?
> >>>>
> >>>> I'm sure I can re-license my submissions. I'd have to look into it.
> >>>
> >>> I'm _not_ sure.
> >>
> >>
> >> This is a new file - it did not exist in v1 - thus you had to write it=
.
> >> If you wrote it, you (or your employer) hold all copyrights, so yes, y=
ou
> >> (or your employer) can relicense it.
> >>
> >> I cannot imagine the case why employer would not like to have dual
> >> license here (it's beneficial to him, so employer would be acting
> >> against himself), but if you need to convince him, you can just say,
> >> that contributing to Open Source project means accepting the licenses =
in
> >> that project. The license for new bindings in this project is (GPL-2.0
> >> or BSD-2), like pointed by checkpatch.
> >=20
> >=20
> > Yes, my employer holds the copyright. However, corporations don't work =
in the way
> > you imagine. There is no one "owner" to speak to about re-licensing. Th=
e people
> > who determine the license is an army of lawyers, with an extensive appr=
oval
> > process.
>=20
> Yes, I understand this. But also how corporations work should not really
> be my problem. Especially that many of them were able to relicense even
> existing work, not mentioning new work. New work is piece of cake
> comparing with army of lawyers for existing, released work! Yet they
> could...
>=20
> >=20
> > What benefit does a BSD license hold for my employer over GPL v2 ?
>=20
> As BSD is permissive, it does not force the employer or its customer to
> release the derived works to customers. GPL requires it (simplifying
> now). The employer and its customer have now choice. Dual license gives
> more choices. More choices is beneficial for the company or its
> customers, isn't?

I don't think we derive value from this because Cisco only sells chips inte=
rnally, not
externally.

>=20
> >=20
> > Here the licenses currently used by the bindings,
> >=20
> >       1 # SPDX-License-Identifier: BSD-2-Clause
> >       1 # SPDX-License-Identifier: (GPL-2.0-only)
> >       1 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
> >       1 # SPDX-License-Identifier: (GPL-2.0-or-later)
> >       3 # SPDX-License-Identifier: (GPL-2.0+ OR X11)
> >       4 # SPDX-License-Identifier: GPL-2.0-or-later
> >       4 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >       6 # SPDX-License-Identifier: (GPL-2.0)
> >       7 # SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> >       7 # SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> >      11 # SPDX-License-Identifier: GPL-2.0+
> >      12 # SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> >      12 # SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >      33 # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> >      47 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> >      56 # SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> >     102 # SPDX-License-Identifier: GPL-2.0-only
> >     350 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >     511 # SPDX-License-Identifier: GPL-2.0
> >     610 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >    1570 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >=20
> > Can you explain why so many are allowed to use GPL v2 , but my company =
is not
> > allowed? Shouldn't these all be dual licensed if the project only allow=
s dual
> > license?
>=20
> The rule is for new bindings. All new bindings are forced to follow this
> rule. Why do you think we treat Cisco special? Who else was allowed? Can
> we be specific?
>=20
> Linking here existing bindings is not really an argument. What does it
> prove?

It shows the "rule" is not consistent. Sometime GPL v2 is ok, sometimes not=
.

Here's is the last GPL v2 only binding added,

commit f9b8556d5799b612404e19b21dd7624d551f71df
Author: Johan Jonker <jbx6244@gmail.com>
Date:   Thu Dec 22 15:28:53 2022 +0100

    dt-bindings: usb: convert fcs,fusb302.txt to yaml

    Convert fcs,fusb302.txt to yaml.

    Changed:
      Add vbus-supply property

    Signed-off-by: Johan Jonker <jbx6244@gmail.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Link: https://lore.kernel.org/r/0336a3c4-4a43-c983-11d7-e2ae16187fc8@gm=
ail.com
    Signed-off-by: Rob Herring <robh@kernel.org>


This was only a few months ago. It's a new yaml file with a new license lin=
e, made
from an existing text file. I can see how maybe this uses parts of the GPL =
v2
txt files so you could not relicense to BSD.

here's one less than a year ago,

commit bdeb3cf013d0d1d09ff3bf66ba139ab259dab3a4
Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon Jul 4 20:24:48 2022 +0300

    dt-bindings: clock: separate bindings for MSM8916 GCC device

    Separate bindings for GCC on Qualcomm MSM8916 platforms. This adds new
    clocks/clock-names properties to be used for clock links.

    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
    Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    Signed-off-by: Bjorn Andersson <andersson@kernel.org>
    Link: https://lore.kernel.org/r/20220704172453.838303-3-dmitry.baryshko=
v@linaro.org


uses one line from a text file that's GPL v2.=20


>=20
> >=20
> > It's very likely that new bindings will be made by making a copy of oth=
er
> > bindings, then make modifications. If my company copied bindings which =
are GPL
> > v2, then we are required to honor the license of the prior binding
> > and that means we legally aren't allowed to relicense under BSD AFAIK.
>=20
> So copy some bindings which are dual-licensed... Since this is new work,
> you can do it.

Writing the binding is already done. It's hard to go back.

Is this dual license mandate documented someplace, because it seems like a
massive trap.

> >=20
> > Also the documentation for the bindings here Documentation/devicetree/
> >=20
> > changesets.rst
> > dynamic-resolution-notes.rst
> > index.rst
> > kernel-api.rst
> > of_unittest.rst
> > overlay-notes.rst
> > usage-model.rst
> >=20
> > all the rst files are GPL v2 and not dual license.
>=20
> These are not bindings, so I do not understand your argument. What do
> you prove? That non-bindings do not have to use bindings rules? Yes,
> they are not bindings...
>=20
> Anyway, I feel like we are making some useless circles and wasting quite
> a lot of energy on trivial rule. I tried to explain it, but if you do
> not like it - it's your choice. It will be a NAK.

I'm pointing out that your dual license mandate has problems. Another issue=
 is
you have dts files exclusively GPL v2, and the dt bindings have dts fragmen=
ts
which then have to be relicensed under BSD.

Are you as well going to nak our dts files? Or are those ok without binding=
s ?

Daniel=
