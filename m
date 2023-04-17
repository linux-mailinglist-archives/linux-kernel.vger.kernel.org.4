Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9E6E4E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDQQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:24:42 -0400
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3380AF16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=204; q=dns/txt; s=iport;
  t=1681748661; x=1682958261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dCZa6IxFFw9MibcNSgybwVByt151nRSFqaII++MsmSk=;
  b=Vt5TrWIoB7qde3cjww2HWBz0UMeTI7GxoYZzsrcQDo1O5kSGN91QHhgT
   QA3RvA/I7CpuKuxgdg3idySR4y7r5O5EVxAFAojaQ87oLZsktr3P8K565
   J6rSpXEGPtWBXSHXe6sevomE7IM524hBIshva1NYwrvVpsbjbhIg5qDRR
   c=;
X-IPAS-Result: =?us-ascii?q?A0BRAABXcT1kmJpdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEYBQEBCwGBW1JzWykSRogeA4UuiDaSIIs8gSUDVg8BAQENAQFEBAEBhQYCh?=
 =?us-ascii?q?TsCJTYHDgECAgIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQEeG?=
 =?us-ascii?q?QUOECeFaA2GBAEBAQMSKAYBATcBDwIBCBgeEDIlAgQOJ4Jcgl0DAaEBAYE/A?=
 =?us-ascii?q?oogeIE0gQGCCAEBBgQFnyEJFoErAZE6JxuBSUSEQD6CYgKFdIIumluBNHaBI?=
 =?us-ascii?q?A6BPIEEAgkCEWuBEAhrgXlAAg1kCw5vgUmBToFcBAIUNg4OHDcDRB1AAws7O?=
 =?us-ascii?q?j01FB8GVoEZJAUDCxUqRwQIOAYcNBECCA8SDwYmRAxCNzMTBlwBKQsOEQNNg?=
 =?us-ascii?q?UYEL4FdBgEmJKMMlhStdgqDfqBtTRODVwESjGaYX5d3gk6lKAIEAgQFAg4BA?=
 =?us-ascii?q?QaBagQvgVtwFYMiUhkPjiAZg1mPeXU9AgcLAQEDCYtFAQE?=
IronPort-PHdr: A9a23:5PjjshcaKt/XPRtiEWW/LSgilGM/fYqcDmcuAtIPkblCdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vehsK22uSt8rXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0wbAuHJOZ+VQyCtkJEnGmRH664b48Mto8j9bvLQq8MsobA==
IronPort-Data: A9a23:j9C+aK8T5a/ngt/G4ycsDrUD8X6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 TFKWjqDPa2JZ2TwL9lxPY/g8EsAv5PdnIVrGgpo/3xEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEjmE4E3F3oHJ9RGQ74nQLlbHILOCa3EZqTNMEn970ko/wrFh2+aEvPDga++zk
 YKqyyHgEAfNNw5cagr4PIra9XuDFNyr0N8plgRWicJj5TcypFFJZH4rHpxdGlOjKmVi8kFWc
 M6YpF2x1juxEx7AkbpJmJ6jGqEBaua60QRjFhO6VoD66iWuqBDe3Y4mH9wZN0J+qgzKkpdv4
 clp8pq8Rlwma/ikdOQ1C3G0EglkNqFAvbTAO3X66oqYzlbNdD3nxPAG4EMeZNJDvL0oRzAVs
 6VFdFjhbTjb7w6y6L6yTOhhgtsqBMLqJ4gY/HpnyFk1CN56GsicEvmWure02h8c259BBaf0d
 fEhRhlXMzXKfTFGPHcYXcdWcOCA3ymjLGIwREiuja425XXDiQ98yr7gNPLLddGQA8ZYhECVo
 iTB5WuRP/0BHMaUxTzA+XW2i6qU2yj6Q4kVUra/85aGnWF/2EQOIzsTC16SgMD6hwmgcs57b
 EoY9XEh+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1O1r4vaLi+p+LjVdJgOteODKp+dtGmN3j
 g7hc8fBQG0w4OfMGBpx45/N9WvqURX5O1PucsPtcOfoy8PorId2hRXVQ5M4VqW0ldbyXzr3x
 lhmTRTSZZ1O1qbnNI3irTgrZg5AQLCTFWbZAS2MBQqYAvtRPtLNWmBRwQGzAQx8BIiYVEKdm
 3MPhtKT6usDZbnUynzUHrtcTOv5t6nfWNE5vbKJN8R6n9hK0yP8Fb28HBklTKuUGp9eIGSwM
 BO7Vf15tcYCVJdVUUOHS9vhV5t1pUQRPd/kTfvTJsFfeYR8cRTvwc2dTRD44owZq2B1yftXE
 c7CKa6EVC9GYYw5l2Deb7lGjtcWKtUWmDm7qWbTlUr3iNJzpRe9FN84Dbd5Rrpnt/vc/FSLr
 Ig32gnj40w3bdASqxL/qOY7BVsLNnM8Q5vxrqRqmiSreGKKxElJ5yft/I4c
IronPort-HdrOrdr: A9a23:uucRMajeXL1brR9234FGHdjMxnBQX4F23DAbv31ZSRFFG/FwyP
 re/sjzhCWE6wr5BktBpTnZAtjxfZq9z/BICYl4B8bbYOF/0FHYbL2KnrGSsAEIfBeOtdK1tJ
 0QMpSWbeeAaGSS4vyKnDVQf+xQpuVvtZrY9Ns2rE0dDz2CCZsQkDuRYzzzeiYdKWUodP5Jc6
 Z0pPA32QZIEk5nFfhTc0N1ItQr0Oe77q4ODyR2fiLPwTP++A9A7oSaLzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pV/grLau59+Lf3JrvJQBiTniw6uaogkcaaFpioJrOam70tvuM
 XQoi0nI9945xrqDyaISFrWqk/dOQQVmiffIGyj8CDeSAvCNWgH4v969Ntkm93imhcdVZ9Hof
 52Nimixuhq5Fv77VDADp7zJlRXfo7emwt9rQbV5EYvDrc2eftfq5cS81hSF4pFFCXm6Jo/GO
 0rF83E4u1KGGnqI0wxk1MfiuBEZE5DUyuuUwwHoIiYwjJWlHd2ww8Rw9EehG4J8NY4R4Nf7+
 rJP6x0nPUWJ/VmI55VFaMEW4+6G2bNSRXDPCabJknmDrgOPzbIp4Ts6Ls46em2cNgDzYc0mp
 7GTFRE3FRCNH7GGImLxtlG4xrNSGKyUXDkzdxf/YFwvvnmSL/iIUS4ORsTegub0r0i6+HgKr
 +O0chtcojexEPVaPB04zE=
X-Talos-CUID: =?us-ascii?q?9a23=3Az5xejGuG4jgeolHMEURJVJXK6Is4WVvYknL5Anb?=
 =?us-ascii?q?7BCF3YaGxDlmc9/hrxp8=3D?=
X-Talos-MUID: 9a23:PHTD0AlZ9oB/TlPm8hysdnpOaZhn+/WEGns1vrY+5OiOKwB5PReS2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 17 Apr 2023 16:24:20 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 33HGOKZj006012
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:24:20 GMT
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:24:20 +0000
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:24:20 +0000
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:24:20 +0000
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:24:20 +0000
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="5.99,204,1677542400"; 
   d="scan'";a="237999"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmCwtsZjmlrxRwxvmwO6oC+fpZMOsmxJ9yJ3gn0FJaXy9lI4txb1GpQEj2Jr92yUxDjaQ8QPfTNVzcyc+Ji6TUSzSaLz0DMoVLIMaLIU6X8OJ5967qV7y72ZousnRiQfvY4oCHreCF8ix52Jy0P8/iA/fi+Egq9iQaxmkVkY1rezrKKjGSVgE0OLtFI0PKB6Jsj+iNFQIQliTo4W99GRUOstW2qSSnvATJE7zLuoJSXAO/3d/FfdTj3v/9DUfpe7jM/WdTFJJRzq43D0lUpuJ3LTNYGoP6RlZlzvFaj/DfzERlBo3jyzV1n7vwL/L8ZCXSPYkHZTrHhDt614k6EhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCZa6IxFFw9MibcNSgybwVByt151nRSFqaII++MsmSk=;
 b=kf9so+XIX8Se/itDlIvLkVUjexMHZCJKHpnHnnmNVVvVaBp/PCV+sbn5aaLyZvioTUR5m1bPEQo6L2pXD7wC5vEJZKMR75r2ViAGOHBjNg1eDsKphtTievI5COHnvpdtxAl4kyE6WOFEvBfM4m6VeC9T7xvvy7Lg9GSdjFZjQFfHHB4idN5QFe5dpqlFZaf1gb7h1zprSyubULbWAuOpsJ3i0CgQzM69xfajuV5zei7sxFfp+z/mOZeGOpKMmXg6RDQK/RVK78BNty/X07D51HtFicH83V78ZYd5Y4uznfSN+f3nMj/Pw1OyNE0FmeThIIoCtZ5E8xao7gwV3hnIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCZa6IxFFw9MibcNSgybwVByt151nRSFqaII++MsmSk=;
 b=b8goBo4LtLJwG/C7du/WyVyuID3kGoASyiVTxpLn+g1GLoYPMDsyh7mCeY/dScfxhGB5kFzeDXEP3Sf6rdkj+cpAIRU7ak2cjS2qu7YmRCvWJshL1RSYs4RMPgZ+bsZHtfyDWV4bl/ex38PUZ+8PjBEc6eiYRQc6itIVxuxvovE=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 16:24:17 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 16:24:17 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "dwalker@fifo99.com" <dwalker@fifo99.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "maksym.kokhan@globallogic.com" <maksym.kokhan@globallogic.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH 1/4] add generic builtin command line
Thread-Topic: [PATCH 1/4] add generic builtin command line
Thread-Index: AQHZcUkOD6ppc7o7REqMkKuIthkl5Q==
Date:   Mon, 17 Apr 2023 16:24:16 +0000
Message-ID: <20230417162415.GF1391488@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
 <20230417161818.2002082-1-tomas.mudrunka@gmail.com>
In-Reply-To: <20230417161818.2002082-1-tomas.mudrunka@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CH3PR11MB7201:EE_
x-ms-office365-filtering-correlation-id: 4cfc4be6-55f8-4203-9a98-08db3f603097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q8mQhRQVLghGKd/wH8NYUjSGCfi0dNw8XC08Au6DqC5rCNVBx4weTW5+z8tVWJls0hgHLBI7elhXsIZ7gTebUPO9SZmlSfcj38GbZBrJ317DGdWGySiYRZN/KLtt1U56jNfleZxwgB88XtfDZ475DI0EnrQ/UBAN6tIGIzqR0DyFeY7cmSAJYM68JlkJnepaX2F3kvxBJCubsBHFtxH41CRVYS5JYC9+TDzB1XUudM1A4OoGj6nzJ7Q3HlKym+i830r5GUP+Cm6IYtAgJcGopd+vEedf2fc+U6ZYLn+gjKmNylAe2XN8oMR/tcND7y6O2bNPogy6tAm4qV3umUf2aNp7IXprjt9zg9yA3GTPYQb+hERLdqlESh3P270uyAHFbAm2ksKwwnH+alzy2BBmLTJInfmfJ8PSAvkIkjvQbEflC5gUg2V3BtJEtp4T+Zv25NXV4vzQEvfxBF6y8fdWOLWNKiVlyh5BpOEVw6ku6Mz92ZjIPLc+oswZ3Ue9erj6ocWpm2sJmNf+S68e3BZH/vXqA6vRpSDphWkP5TCPIaAS0yQnGHSkKkzThYDBQ4sDjd7XR2NLmphmUbtk+a4jXEQ5qNSeB4eCip6nVzSXY0iRISKOyujjCc2FP3CtROyqeLw/JU/4/B92BLAHas1zIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(6486002)(478600001)(86362001)(71200400001)(558084003)(26005)(83380400001)(33656002)(107886003)(6506007)(186003)(6512007)(9686003)(1076003)(38100700002)(38070700005)(122000001)(33716001)(64756008)(6916009)(76116006)(66446008)(66946007)(66476007)(66556008)(316002)(2906002)(4326008)(8936002)(5660300002)(8676002)(41300700001)(54906003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tlmGXlvfmrI/RoC+yvY9p+QZ6Wqd2bdbE9HM4wWfZ6DqVsBp/dD0mMBzohk8?=
 =?us-ascii?Q?10aQyxbkUG5eFyydMzmXbRFNuG/0j6AICpTYdn4iW8MViN2D6wF4GkQSMpMh?=
 =?us-ascii?Q?OZ6tVH/ZP8YKIg+GvmZpWHHYK9xNlormSvbmK0Rf1hFw9ddnI28XZW4buWuY?=
 =?us-ascii?Q?gKsqYlH7WYFDjSJYNRDODVYr2QmC+a0kG7sxWuDaHHDXk2Zq6nvG4o1v5tVJ?=
 =?us-ascii?Q?qD5earixYaGb7HV/Q0S81DU/3Rn4iL8p5Q+N3/DUHhRx9xy+vNi5SBV0iZb7?=
 =?us-ascii?Q?C/omLKiDArPWN/ztGoUk9v/ofU5nzw1wI+/Qw10oMFX0BLAb1duf/QMdun+q?=
 =?us-ascii?Q?kMFStAmbeVdyFmQ3iv6KQPLSjA9iY3LfbyIicbfDFiYF6tGl8UNH1EzmnEel?=
 =?us-ascii?Q?ERu4uniGUaGOeQTnT7yA4q2qcy7iozVT1WhJ0XxoEyh3YIwuXyoO/vVErdo0?=
 =?us-ascii?Q?1DJ+R0kz8VfHxKTnx/oLUsrhncsCNfwkNFp7CNJZQscmr18RqdiRsM/07Ig5?=
 =?us-ascii?Q?N7Ai3PSHboQMAej0hEjZmdLtxrBX9JWD6neQrqrQ9/XHnE91YPC6VwNJ/cjr?=
 =?us-ascii?Q?Zdg/lk6HtGpnUdQewlOJXy8DOgYC91A/L/aXc9t3QeMMtloH/lYnH4YUU52V?=
 =?us-ascii?Q?pxDjmrNrJ8PeboGLawsJZeIG8PD+wtt5hZB5WsZ3KiYY3GncoKdtkVwjlc4p?=
 =?us-ascii?Q?CITvHiQkDthwKYs7AczEHCyy+1elUW7UQyPRsvbtuQdS68PpDTWMMGLVEBRK?=
 =?us-ascii?Q?Vz+F4UiSHixUQLiV4MRLu8OhjUioZhehqYhxF9X4POcaqBdTKL4Pw/Xsejk4?=
 =?us-ascii?Q?C3Fj9eL7Ca6Mz39bfeqX5dXKwTiQs9V3VSaIRg4yAPJQbKywvjdSD9Ds9QRt?=
 =?us-ascii?Q?uMGi09Vu9yqViXEqKdp5TwXxoMjex0MsY/2+V8rRsmiRMZYXGeSJ3+CMEfTu?=
 =?us-ascii?Q?evms0QWKdTysNfP2QExXc4T9YLbh4KNINW/WNLigMUtj1szUUODytI+SClgM?=
 =?us-ascii?Q?chJDuvVoRY/642+L9DE7+sPX+5H51kjN3ygqAJzKp7yz2MleONKnwf8hlOPw?=
 =?us-ascii?Q?hRvrL2JJVRqIH0HgTbxQyOyVpAiZupdVUaPoD+s303PpC2LdN0mWqEsnpNyA?=
 =?us-ascii?Q?K7NIG8gFHaRk0p+7EJqGwCszvUaOpRbuZ+sPNkS677dMie7XRtE52HVpl5Fa?=
 =?us-ascii?Q?KCKh419jLJOJGXkVbDgmfqasVlQ6C3U9bIkLdJ1no0DpS9BGTsZq8sPKXrVr?=
 =?us-ascii?Q?r2eIgpHa0aJsGxhgnrDatYfbGGsxKAJZ1A75Ls5gEmj5QDNnZYI0NOBXUl6P?=
 =?us-ascii?Q?Dwk4Kmr9qoqZn+crBor3Fyd0fM5+gxSad8MwdTfZ4T6cX3OqEEeh47Q1/AHb?=
 =?us-ascii?Q?9+i7W+G3+Nj0orcsugLtV7MkoGOVujvAgXd4HInQKfvrmdun1D9y3x19hAJa?=
 =?us-ascii?Q?pfShxXLYQ0mjfA1LSQBI46ToOuAuvBoPsOMx9s69Yw2Y/PYApgTetRQkI4MB?=
 =?us-ascii?Q?vgDVZpqK5BRFidaOmlh8Eei6PgjH2GnLVCIxv8qLUl9d7fgXRSycVDQBG5/M?=
 =?us-ascii?Q?zxHpALiql/dzq7hedgThFD8XBHw/38hZ2PeBrT77ZMS4eTkk9CL35ss1B5Ro?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4BBE78A48344874283E8B1EE5EC9FE58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfc4be6-55f8-4203-9a98-08db3f603097
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 16:24:16.7337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAoVtIGQw0jsRlcOjC3NhdZmONWOIoWBCP8sjUtxGQ7WIOL4Dc30xfQxP6vAyF8tbQUSgTozYhpeEjTUgJMcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:18:18PM +0200, Tomas Mudrunka wrote:
> This seems quite useful. Can you please merge it?

I need to re-send it before it can be merge. I'll try to update it soon.

Daniel
