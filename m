Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C25F6DA723
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbjDGB7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDGB7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:59:00 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62E7DBF;
        Thu,  6 Apr 2023 18:58:58 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N3HZA032194;
        Thu, 6 Apr 2023 18:58:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=UcoBQalVtuUM+oT522HgC+EZcMZrz3IYaq1iq4RGd2Y=;
 b=Fg5JAeJ/+3lSQY9lNVrLPDGEBueBPzdvI4Aroy6+J/ScPCJERCGrgdnNTnzbWZpcFRaK
 AO+5T6n+q2AwjJB3kgMqkS1gye0pk/vc07ln6ipC3xMTWrRhGzDOwjZTfm0pnCQobUxu
 Vmp8ZgGlXERQYZvsZMlJek+vPKjBPcTPRxqT9QVMIUoT2R8lOAwAhe9zGl6SqInQm2kZ
 Au+ZlkCtYRS/hHLRPUOWxMoLQd6oxMXEyT3MADWOu5wgsFH9Ml7BO+SashXFXl2tvPd7
 mZLUlu4hLUnGZSffFJlsnRrHuSgcv7NCCzSRnZqSfnzBjinJH20XYy3LVbTfxJHGkfZR xw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkv9eu8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 18:58:52 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7C77F400B4;
        Fri,  7 Apr 2023 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680832732; bh=UcoBQalVtuUM+oT522HgC+EZcMZrz3IYaq1iq4RGd2Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eThEzeKhIzRtTP8BpGSNrElNY0sLZYETweTwII1rvmQVhW3DmR9lK3eZYut55o3eT
         TBv1xPJCm8Hd/kiMOB2pKDLzpgEtify/ktkbuAiFhpBVgNJ2zhzIpkIb0E5YKo8QxG
         6RPb6loJRdKYIeLYuutp8mouai8Ydnb7xrcok/JfxkCy6K7Vh/0s/5tGrTDne0kfKO
         SvpvpsvBHh3O0yCN7jaGpxxI8uOUzKHixd/NTtp1OinS/4yhM4MNvEzoiF8NEg+F4C
         5m/Xp4cUxsGQb5V+thcxTMVdf1l/TEoGe6ET3FUPx+vP3aSc+SPZ8zLIcbbKPf161e
         foBAVDvdpcfPQ==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2150FA007A;
        Fri,  7 Apr 2023 01:58:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C32CB40042;
        Fri,  7 Apr 2023 01:58:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hVKLqHhm";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8hD4LtRzD5YnfKp8BPE7Q8N69km3znw5xqPsOpnYLF1CeU2YF2nqrLiCqgd0+PVIkjrIv4QRdB+xDurM9GXQRY24IFBXpvld/Vt3tabQwhvLL9oF26YUgCXmz8wqwZpJlm6ILxY0SRmnXMcEQ0Xkjqwf5mjtXzNcTZjOZfjgzmIuemOg6EovDvuMggIzuHIwV9xpfR6euvalefjUZvsKu0yIhn8my+O8+TvnLAb8U+/0z7N/X09AzTdvV2dRbxGovihpZPKlSdPD3z5O7if2y0YgL7U9um1dEx128mswnz4hmjjyOhv3rOUlbV4Ujwhi5Ksqe4znHstfd2QnJpglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcoBQalVtuUM+oT522HgC+EZcMZrz3IYaq1iq4RGd2Y=;
 b=meSdT8fYoPynElJQwlDVVvuaKVxrDY6SuTj/PM9NytbNjZeeJBM7sqJazEVC4btj8HOK63XGBYpn5vJhRCuVoCWMsasiTiXkyGMchQTTIkcsPsLdGzn9zos0bleve54r2IUsX8DHbLzJMKFDgjv96OVChFxpm1Bw1VGcVX4a6BhhbYLigehj/UbNXDEgUaSAssnGA8V7mR9cVnn7yJFQL0FLu7cQTLTZuBYNvmkVsa4ESdPqf9nxDCOWHfmzPhHv2CstTBl4pl5O35qFExseau52F252QnWOd0YYnoOIu3TdMWwvAfU0eKIizALWonQLWzMwRCgxWf3iQeHfKvufmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcoBQalVtuUM+oT522HgC+EZcMZrz3IYaq1iq4RGd2Y=;
 b=hVKLqHhmJqrceuWb6G4THSbedoBRFPztYa0oA1ZGD++5PFnaxyvm+OTAI0CtC90JWmAMhfTc3k6NW2B/G9dOdkv+B3BaJRS+vcyWxDZNcGJrfpsq/RTsgCsJ3SSYhWQnLO6D7qNOKhXT3fCxUSduv6mXJI4izm7JiMT3rGW1gSk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 01:58:48 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 01:58:48 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] USB: dwc3: drop dead hibernation code
Thread-Topic: [PATCH 05/11] USB: dwc3: drop dead hibernation code
Thread-Index: AQHZZsazjU+rx9LwaE2eC6z9VtBJ868fG1yA
Date:   Fri, 7 Apr 2023 01:58:48 +0000
Message-ID: <20230407015833.3x6fdw2rwemsul7t@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-6-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-6-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA1PR12MB6895:EE_
x-ms-office365-filtering-correlation-id: 5cade0ac-c57e-4486-3a72-08db370ba090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixd33C1zAHRVM/rxedT3wEuhWDYpHaS36rzKHDRal88pC56YB33SS+jFmOBDWK+rsZULZHFcM+KvsBkF7zBk+XA2BPz/Xbs2+L2GHBSS4iBoxOhQYcU9uPxBzhWeMuXGT/3YIHcaDXVgzLLlT5ygV2FtjEEXTga7EuBq1iEWQmGBUnXjBGjpQI/2lCaTND9wnmRRSm5RpUr89WTr/KCYLHQBvqnXT99xjekdIeTamDmcoSt4hhrMNuHx0tHgyActdncV3n+v58fBEHSVkj8i4E/zlNY1/ZyPlEnXoKe5LJHRmMostO75beyIxk9pmHNAyQvjlpKjm9F/BlSMO1j3u1n0WhbrHzZ0b0L0h2f8frkV6Nh57OuGI2jfxBHnanICy86W0d6sbmYMjKoc/V+S+651BNoufezn6WEqmKJCsOJSSFIB0pqMezL+twnpH1PNZ1iCXJGi6pX6vSShXNaTwljNbxVkY8xaekhmHBXIHe1RZNV/0vFGmNzwZHsDFhtGLKatb4oxjlGJK/T2JTSVG+qw1eKcXRhKU4dLeD1UBU1KrXQPnTjbLx5jt1inDBgwf/W8jGwOhgCOMQPaiTF7GgTXIIcmH2B6E6veKih2aiDTbDwhbbs5KJaNktWsc85o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(41300700001)(26005)(6506007)(1076003)(6512007)(186003)(8936002)(36756003)(8676002)(76116006)(64756008)(66946007)(6486002)(316002)(66446008)(66476007)(66556008)(4326008)(478600001)(71200400001)(54906003)(5660300002)(122000001)(38100700002)(38070700005)(2616005)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGx5UDRBYjk3OXlrTHF2Q3dOM2hxMi9kSmtETTloWjR1WUw5VC9LU0IzaWFk?=
 =?utf-8?B?SEJncVduWDVENjlHTjVlT1h0ZDFZK3RxYWhVZjNwNTBoaGEwdi9NeW4wMGd4?=
 =?utf-8?B?clhHTi8yajJubVR2bEtOOHNJYTZhYUEvZzVRSnRXSFdBajhia2x1NVVNZmNi?=
 =?utf-8?B?T3NUb3l6eDhnRHRaa0s4VWROeXpVNW01YTBKOHVZNGxIQlhPbWRoQ0VReTl6?=
 =?utf-8?B?NUV2bHNHeEc0bFc0NGZxNnhsNG1vUEI4U1BZWjc0TVZEUEFLa21sTXhiZTFs?=
 =?utf-8?B?TUtxeURIejV5Z0ZOazBwSlBZUXRNRzZHM2M5TU1XNHAzZGIxYTJ2aFc2L3Z0?=
 =?utf-8?B?Um5yblQvYmNkSm1mY3dmakl1dXJoNmJUTktWYXdWc0tUaHhxUmp6azVIRGFs?=
 =?utf-8?B?QzNSd0VBMmJEbVNzTmZpLzdUOHFFR3UxWFlpL21rcWZSVzlQK3hpU1pZK2hM?=
 =?utf-8?B?N096WlAwUThiWVV1NG05ZERxQ3NXYjRqTXRrTlN1RVN4emJQSXVBaVVNbWdF?=
 =?utf-8?B?T29LTGtWRU9jcTdBRmZMNXJQN3BweDQ2bHJyVzZwaWNvbjNwUFdiTFZtR3Bh?=
 =?utf-8?B?eHZGZ09JQlZEWjJNMkY2ZGFoOGlia1VidXZDME1lOFp3bUdlenNZaGlGekc2?=
 =?utf-8?B?dEZPdnkvRjYrd0R0dHNRN2xnVXlwVU9sRWFmeGpMTVhIQlU3aVd2Mk9IUGto?=
 =?utf-8?B?bENNbWl2bU1IZWlkcGc2RjVtbndLc09LVjNWM2t6dUd1ejFuUTFkcitqS1B3?=
 =?utf-8?B?bHRrejI5RGFWM3ptR0g0bVFiUjhWTGNRNk1QaGEvU1YyUFRXWWhJQXp5SktO?=
 =?utf-8?B?QjFnVFVNR2h5RmlnUWkrUmNxNnVXWVJZVFo5b3lGbGVKZEMvUUg0RHlzazRx?=
 =?utf-8?B?Q2MwdG9SQVlKZkZ0eUlNL3dSSm5lVUxDd21KcnJveUFWeklhMTlxVTd3cDJm?=
 =?utf-8?B?Y1FGaStGMEdvbnlxT21FcHdWVmFOdTRkTTFLbmxYdDd2bTgwK1pzUUNheEo4?=
 =?utf-8?B?eVFQSUQ0V2ViTzh6U3EyTFM4bzU1TEVkWm9zV0d2M1A5UTd0TEJrZUZPUW5r?=
 =?utf-8?B?ZTZDaDBXMDF6aGJuTVVBaHhHTFNMTWRYT2x0aENmdGFPczRaUUxBVXIraER3?=
 =?utf-8?B?VVZsMnJGUzd3bDUvZDBlb2V6MzBZUVlONHpPQWsrYndWS0drSFZrY3dvOUJH?=
 =?utf-8?B?L0o2enRwNjhUYStKTnQ5dnNJUEJjV3Zzb0dqck9yR282a3pyUzFidE92QUp5?=
 =?utf-8?B?R0Y1RjUwdC9JMVBrQUdPQjlwQVNsOW5IaEZMd2ZzZWVPSVArYjdmM3J1TFFP?=
 =?utf-8?B?RVRUa3Qyczc0RzFhWm5ESnVUbHJtNk9CWktBakdTRjFWdU9TMHZNU2haSk40?=
 =?utf-8?B?djNWMGs4T2xSamN1aVNtWXg5UWNWaFA0RWFyTTI5NmFNaHdLQ3lzNXdhazRZ?=
 =?utf-8?B?c2pzZFNQcXZ6QmRvRy9hbHVJZ3A5b1htaVZ3N2t4aUJDdXJyQkoxWWVWbWR3?=
 =?utf-8?B?SHBNR1dHa21NWmI3UGNwT1hUL2tJWUtoWk5YTEFVU2hZWmRUdVJIdWtCcVMy?=
 =?utf-8?B?Nk4wdEtmaGZrSTZYMllPeHJwSStYRGRsU2ZUZjVSMWZ1UGhZdHVrM1N6ZzZr?=
 =?utf-8?B?S2E4eFN4Y1doK25uTEV5NGZPL2UzeXhtdW83UW9oenR3aE1oNFNXU1lMaVhs?=
 =?utf-8?B?ZXFObGlZQjArYWFYV2NzUWYwemxIdm1tN3N0WU45Y0VmTTlzVFBSTy9IcG9L?=
 =?utf-8?B?Mjd3MG5kaW5LSDh3YXM2cmg2OFIrUGdvbWJCR3FwbGF1aDRSU0FwVHpUcWZD?=
 =?utf-8?B?REpkK1lxZElKMjEwT1JPK25POG5SN1Z4WlN6RGRhRzJxbXNVVnd1dkpsSGZH?=
 =?utf-8?B?ckkxT2VvdUpacnVxNWN4WWNlUU85N0xyMHZKUHRlekhFbHNFVE5zSzFRWXVV?=
 =?utf-8?B?SjJZUkR3VExiOHFHdms1a0F2S1dpUmZFdUZpYlFFMGVOdDZCRmFqL3pnaGNy?=
 =?utf-8?B?K1hROXF4Z24rQzlZTnVwYVFwQzByVmRrbEZ4SWFkYzdobVdGY0ZBaUpZdWhJ?=
 =?utf-8?B?MlRnU3pIUnF2dmxldUQ3dXB3NkIvY0k1RDErUjRtdUVkYlVqZ0VBTXl4VTJV?=
 =?utf-8?Q?RaKJ/QtqdGqNUlTDUfbkOvG+C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DB9510E37537340BD591994F75ADEFD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fiv/Z2cmV9+T3ADgUaVrstiI0v2r9fOmO7lCQtIDHVAL/bjqOdKfljJX9YYISHWHG/by8rcb00COzQwQdis4rLzClkWoPltLGJbep9uEwxS2N1B0HqcampBZRgqbSvn0jzxk61X7an7qx+5rDAocu3JBHGGVDG/TYTs06QxKmW7SoDi+1Vfp6SQF8D/E7SZJ6tWWeYhCko+6tMW8XLS9IOSPsPih1WzzaR/lfZlP9JREyu2O4XEl0hQr85TN7XohYwH5rg1iUDYLlpcoalevm0sEFaAPHc9tTJwVTd02PQituB0kYLt0BXjX7wsDZhfnwFFsM53+V4EGcQ0OMt+bFZGOilrQizKmxIcwZxreFLZjIO5nCgVdhW5FHLORw1y0eim1aoKkACwfXTV5q1BppmuLeUZ+3mZ7J42Ae6wBi0a3t4E3YEAuWwVEr64fzhSITIQLXBGX/Ap1Tb3xfte7I9pcuFfZB5Vd5F2HfypIDMmZwYUNm08haMCMMek1nLwmzpFqWkhRsgQE1Wq0Om6qjRgaopj2/4iAfjjkZCI0rI0741Ih4s2Y9Vu9Nzmn+opNOmtAkzAcFozjz560qatGqwyNURCFK080SFXQiapvvGMjWadKpoGJhlyhKklwiHVvz6X7Gb40wHHdx6X/3228DD1Ojs1pwV/YYFnzouTnvB+GZiPVm/YzelK0UBl92zOe/4ZarUrvrhx9S3chGSbcn2GhU3mTPO/0nM5jxDHAQI48/u8G5PuwOiIl0VUH4cWISg5wk74wur6sqbEJus0SisqmlVdpB0ay8Hht/Bk0VNWz/vPtG6tOqg83bxuJ9Jd9xWMX4+8Qzj453MCUkoOdmV2PD1IzcwxUyKmbs//rykzsp0rXh1zVUP6tfF/W90GB
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cade0ac-c57e-4486-3a72-08db370ba090
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 01:58:48.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvVUjlNCzY87OUDJtWYxzG/9jPaGpsJWtTs9I/11Pszj9f5bsGG2sVUztFuNm8aN0lX6YI8SpqHOuAg4dNbyYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
X-Proofpoint-ORIG-GUID: 2GWzS4sCaOl1arbz_az0vwy9t0RAhy5F
X-Proofpoint-GUID: 2GWzS4sCaOl1arbz_az0vwy9t0RAhy5F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070017
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gVGhlIGhpYmVybmF0
aW9uIGNvZGUgaXMgYnJva2VuIGFuZCBoYXMgbmV2ZXIgYmVlbiBlbmFibGVkIGluIG1haW5saW5l
DQo+IGFuZCBzaG91bGQgdGh1cyBiZSBkcm9wcGVkLg0KDQpIaWJlcm5hdGlvbiBpcyBub3QgaW1w
bGVtZW50ZWQgaW4gdGhlIGtlcm5lbCBtYWlubGluZS4gV2Ugb25seSBoYXZlIHNvbWUNCnNtYWxs
IHN0dWIvcGxhY2Vob2xkZXIgY29kZSBmb3IgaXQuIEl0J3MgZmluZSB0byByZW1vdmUgdGhlc2Uu
DQoNCj4gDQo+IFNwZWNpZmljYWxseSwgdGhlIHNjcmF0Y2ggYnVmZmVyIERNQSBtYXBwaW5nIHdv
dWxkIGhhdmUgYmVlbiBsZWFrZWQgb24NCj4gZXZlcnkgc3VzcGVuZCBjeWNsZSBzaW5jZSBjb21t
aXQgNTFmNWQ0OWFkNmYwICgidXNiOiBkd2MzOiBjb3JlOg0KPiBzaW1wbGlmeSBzdXNwZW5kL3Jl
c3VtZSBvcGVyYXRpb25zIikgaWYgdGhpcyBmZWF0dXJlIHdhcyBldmVyIGVuYWJsZWQuDQo+IA0K
PiBUaGUgcmVsYXRlZCBlcnJvciBoYW5kbGluZyB3YXMgYWxzbyBicm9rZW4gYW5kIGNvdWxkIGhh
dmUgcmVzdWx0ZWQgaW4NCj4gYXR0ZW1wdHMgdG8gdW5tYXAgbmV2ZXIgbWFwcGVkIGJ1ZmZlcnMs
IGV0Yy4NCj4gDQo+IFRoaXMgZWZmZWN0aXZlbHkgcmV2ZXJ0IGNvbW1pdCAwZmZjYWYzNzk4YmYg
KCJ1c2I6IGR3YzM6IGNvcmU6IGFsbG9jYXRlDQo+IHNjcmF0Y2ggYnVmZmVycyIpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz4NCj4g
LS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDEwMyArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCB8ICAgOCAt
LS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMTAgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBpbmRleCA1YjM2MmVkNDNlN2UuLmQ4MzdhYjUxMTY4NiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gQEAgLTUzNCw5MCArNTM0LDYgQEAgdm9pZCBkd2MzX2V2ZW50X2J1ZmZlcnNf
Y2xlYW51cChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdD
M19HRVZOVENPVU5UKDApLCAwKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGludCBkd2MzX2FsbG9j
X3NjcmF0Y2hfYnVmZmVycyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAtew0KPiAtCWlmICghZHdjLT5o
YXNfaGliZXJuYXRpb24pDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JaWYgKCFkd2MtPm5yX3Nj
cmF0Y2gpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JZHdjLT5zY3JhdGNoYnVmID0ga21hbGxv
Y19hcnJheShkd2MtPm5yX3NjcmF0Y2gsDQo+IC0JCQlEV0MzX1NDUkFUQ0hCVUZfU0laRSwgR0ZQ
X0tFUk5FTCk7DQo+IC0JaWYgKCFkd2MtPnNjcmF0Y2hidWYpDQo+IC0JCXJldHVybiAtRU5PTUVN
Ow0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBpbnQgZHdjM19zZXR1
cF9zY3JhdGNoX2J1ZmZlcnMoc3RydWN0IGR3YzMgKmR3YykNCj4gLXsNCj4gLQlkbWFfYWRkcl90
IHNjcmF0Y2hfYWRkcjsNCj4gLQl1MzIgcGFyYW07DQo+IC0JaW50IHJldDsNCj4gLQ0KPiAtCWlm
ICghZHdjLT5oYXNfaGliZXJuYXRpb24pDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JaWYgKCFk
d2MtPm5yX3NjcmF0Y2gpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JIC8qIHNob3VsZCBuZXZl
ciBmYWxsIGhlcmUgKi8NCj4gLQlpZiAoIVdBUk5fT04oZHdjLT5zY3JhdGNoYnVmKSkNCj4gLQkJ
cmV0dXJuIDA7DQo+IC0NCj4gLQlzY3JhdGNoX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShkd2MtPnN5
c2RldiwgZHdjLT5zY3JhdGNoYnVmLA0KPiAtCQkJZHdjLT5ucl9zY3JhdGNoICogRFdDM19TQ1JB
VENIQlVGX1NJWkUsDQo+IC0JCQlETUFfQklESVJFQ1RJT05BTCk7DQo+IC0JaWYgKGRtYV9tYXBw
aW5nX2Vycm9yKGR3Yy0+c3lzZGV2LCBzY3JhdGNoX2FkZHIpKSB7DQo+IC0JCWRldl9lcnIoZHdj
LT5zeXNkZXYsICJmYWlsZWQgdG8gbWFwIHNjcmF0Y2ggYnVmZmVyXG4iKTsNCj4gLQkJcmV0ID0g
LUVGQVVMVDsNCj4gLQkJZ290byBlcnIwOw0KPiAtCX0NCj4gLQ0KPiAtCWR3Yy0+c2NyYXRjaF9h
ZGRyID0gc2NyYXRjaF9hZGRyOw0KPiAtDQo+IC0JcGFyYW0gPSBsb3dlcl8zMl9iaXRzKHNjcmF0
Y2hfYWRkcik7DQo+IC0NCj4gLQlyZXQgPSBkd2MzX3NlbmRfZ2FkZ2V0X2dlbmVyaWNfY29tbWFu
ZChkd2MsDQo+IC0JCQlEV0MzX0RHQ01EX1NFVF9TQ1JBVENIUEFEX0FERFJfTE8sIHBhcmFtKTsN
Cj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnIxOw0KPiAtDQo+IC0JcGFyYW0gPSB1cHBl
cl8zMl9iaXRzKHNjcmF0Y2hfYWRkcik7DQo+IC0NCj4gLQlyZXQgPSBkd2MzX3NlbmRfZ2FkZ2V0
X2dlbmVyaWNfY29tbWFuZChkd2MsDQo+IC0JCQlEV0MzX0RHQ01EX1NFVF9TQ1JBVENIUEFEX0FE
RFJfSEksIHBhcmFtKTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnIxOw0KPiAtDQo+
IC0JcmV0dXJuIDA7DQo+IC0NCj4gLWVycjE6DQo+IC0JZG1hX3VubWFwX3NpbmdsZShkd2MtPnN5
c2RldiwgZHdjLT5zY3JhdGNoX2FkZHIsIGR3Yy0+bnJfc2NyYXRjaCAqDQo+IC0JCQlEV0MzX1ND
UkFUQ0hCVUZfU0laRSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiAtDQo+IC1lcnIwOg0KPiAtCXJl
dHVybiByZXQ7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIGR3YzNfZnJlZV9zY3JhdGNoX2J1
ZmZlcnMoc3RydWN0IGR3YzMgKmR3YykNCj4gLXsNCj4gLQlpZiAoIWR3Yy0+aGFzX2hpYmVybmF0
aW9uKQ0KPiAtCQlyZXR1cm47DQo+IC0NCj4gLQlpZiAoIWR3Yy0+bnJfc2NyYXRjaCkNCj4gLQkJ
cmV0dXJuOw0KPiAtDQo+IC0JIC8qIHNob3VsZCBuZXZlciBmYWxsIGhlcmUgKi8NCj4gLQlpZiAo
IVdBUk5fT04oZHdjLT5zY3JhdGNoYnVmKSkNCj4gLQkJcmV0dXJuOw0KPiAtDQo+IC0JZG1hX3Vu
bWFwX3NpbmdsZShkd2MtPnN5c2RldiwgZHdjLT5zY3JhdGNoX2FkZHIsIGR3Yy0+bnJfc2NyYXRj
aCAqDQo+IC0JCQlEV0MzX1NDUkFUQ0hCVUZfU0laRSwgRE1BX0JJRElSRUNUSU9OQUwpOw0KPiAt
CWtmcmVlKGR3Yy0+c2NyYXRjaGJ1Zik7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyB2b2lkIGR3YzNf
Y29yZV9udW1fZXBzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfaHdw
YXJhbXMJKnBhcm1zID0gJmR3Yy0+aHdwYXJhbXM7DQo+IEBAIC04NzcsNyArNzkzLDYgQEAgc3Rh
dGljIGJvb2wgZHdjM19jb3JlX2lzX3ZhbGlkKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIHN0
YXRpYyB2b2lkIGR3YzNfY29yZV9zZXR1cF9nbG9iYWxfY29udHJvbChzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgew0KPiAtCXUzMiBod3BhcmFtczQgPSBkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNDsNCj4g
IAl1MzIgcmVnOw0KPiAgDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR0NU
TCk7DQo+IEBAIC05MDUsOSArODIwLDYgQEAgc3RhdGljIHZvaWQgZHdjM19jb3JlX3NldHVwX2ds
b2JhbF9jb250cm9sKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCQlyZWcgJj0gfkRXQzNfR0NUTF9E
U0JMQ0xLR1RORzsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBEV0MzX0dIV1BBUkFNUzFfRU5fUFdS
T1BUX0hJQjoNCj4gLQkJLyogZW5hYmxlIGhpYmVybmF0aW9uIGhlcmUgKi8NCj4gLQkJZHdjLT5u
cl9zY3JhdGNoID0gRFdDM19HSFdQQVJBTVM0X0hJQkVSX1NDUkFUQ0hCVUZTKGh3cGFyYW1zNCk7
DQo+IC0NCj4gIAkJLyoNCj4gIAkJICogUkVWSVNJVCBFbmFibGluZyB0aGlzIGJpdCBzbyB0aGF0
IGhvc3QtbW9kZSBoaWJlcm5hdGlvbg0KPiAgCQkgKiB3aWxsIHdvcmsuIERldmljZS1tb2RlIGhp
YmVybmF0aW9uIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQuDQo+IEBAIC0xMTUxLDEwICsxMDYzLDYg
QEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNf
Y29yZV9zZXR1cF9nbG9iYWxfY29udHJvbChkd2MpOw0KPiAgCWR3YzNfY29yZV9udW1fZXBzKGR3
Yyk7DQo+ICANCj4gLQlyZXQgPSBkd2MzX3NldHVwX3NjcmF0Y2hfYnVmZmVycyhkd2MpOw0KPiAt
CWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyMTsNCj4gLQ0KPiAgCS8qIFNldCBwb3dlciBkb3duIHNj
YWxlIG9mIHN1c3BlbmRfY2xrICovDQo+ICAJZHdjM19zZXRfcG93ZXJfZG93bl9jbGtfc2NhbGUo
ZHdjKTsNCj4gIA0KPiBAQCAtMTkwOCwxNCArMTgxNiwxMCBAQCBzdGF0aWMgaW50IGR3YzNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3Rv
IGVycjM7DQo+ICANCj4gLQlyZXQgPSBkd2MzX2FsbG9jX3NjcmF0Y2hfYnVmZmVycyhkd2MpOw0K
PiAtCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyMzsNCj4gLQ0KPiAgCXJldCA9IGR3YzNfY29yZV9p
bml0KGR3Yyk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAi
ZmFpbGVkIHRvIGluaXRpYWxpemUgY29yZVxuIik7DQo+IC0JCWdvdG8gZXJyNDsNCj4gKwkJZ290
byBlcnIzOw0KPiAgCX0NCj4gIA0KPiAgCWR3YzNfY2hlY2tfcGFyYW1zKGR3Yyk7DQo+IEBAIC0x
OTQ0LDEwICsxODQ4LDYgQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJcGh5X2V4aXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5KTsNCj4gIA0K
PiAgCWR3YzNfdWxwaV9leGl0KGR3Yyk7DQo+IC0NCj4gLWVycjQ6DQo+IC0JZHdjM19mcmVlX3Nj
cmF0Y2hfYnVmZmVycyhkd2MpOw0KPiAtDQo+ICBlcnIzOg0KPiAgCWR3YzNfZnJlZV9ldmVudF9i
dWZmZXJzKGR3Yyk7DQo+ICANCj4gQEAgLTE5ODcsNyArMTg4Nyw2IEBAIHN0YXRpYyBpbnQgZHdj
M19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlwbV9ydW50aW1lX3Nl
dF9zdXNwZW5kZWQoJnBkZXYtPmRldik7DQo+ICANCj4gIAlkd2MzX2ZyZWVfZXZlbnRfYnVmZmVy
cyhkd2MpOw0KPiAtCWR3YzNfZnJlZV9zY3JhdGNoX2J1ZmZlcnMoZHdjKTsNCj4gIA0KPiAgCWlm
IChkd2MtPnVzYl9wc3kpDQo+ICAJCXBvd2VyX3N1cHBseV9wdXQoZHdjLT51c2JfcHN5KTsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmgNCj4gaW5kZXggNDc0M2U5MThkY2FmLi5mYmJjNTY1ZDNiMzQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IEBAIC05NjksMTIgKzk2OSwxMCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsN
Cj4gICAqIEBkcmRfd29yazogd29ya3F1ZXVlIHVzZWQgZm9yIHJvbGUgc3dhcHBpbmcNCj4gICAq
IEBlcDBfdHJiOiB0cmIgd2hpY2ggaXMgdXNlZCBmb3IgdGhlIGN0cmxfcmVxDQo+ICAgKiBAYm91
bmNlOiBhZGRyZXNzIG9mIGJvdW5jZSBidWZmZXINCj4gLSAqIEBzY3JhdGNoYnVmOiBhZGRyZXNz
IG9mIHNjcmF0Y2ggYnVmZmVyDQo+ICAgKiBAc2V0dXBfYnVmOiB1c2VkIHdoaWxlIHByZWNlc3Np
bmcgU1REIFVTQiByZXF1ZXN0cw0KPiAgICogQGVwMF90cmJfYWRkcjogZG1hIGFkZHJlc3Mgb2Yg
QGVwMF90cmINCj4gICAqIEBib3VuY2VfYWRkcjogZG1hIGFkZHJlc3Mgb2YgQGJvdW5jZQ0KPiAg
ICogQGVwMF91c2JfcmVxOiBkdW1teSByZXEgdXNlZCB3aGlsZSBoYW5kbGluZyBTVEQgVVNCIHJl
cXVlc3RzDQo+IC0gKiBAc2NyYXRjaF9hZGRyOiBkbWEgYWRkcmVzcyBvZiBzY3JhdGNoYnVmDQo+
ICAgKiBAZXAwX2luX3NldHVwOiBvbmUgY29udHJvbCB0cmFuc2ZlciBpcyBjb21wbGV0ZWQgYW5k
IGVudGVyIHNldHVwIHBoYXNlDQo+ICAgKiBAbG9jazogZm9yIHN5bmNocm9uaXppbmcNCj4gICAq
IEBtdXRleDogZm9yIG1vZGUgc3dpdGNoaW5nDQo+IEBAIC05OTksNyArOTk3LDYgQEAgc3RydWN0
IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAY3VycmVudF9vdGdfcm9sZTogY3VycmVu
dCByb2xlIG9mIG9wZXJhdGlvbiB3aGlsZSB1c2luZyB0aGUgT1RHIGJsb2NrDQo+ICAgKiBAZGVz
aXJlZF9vdGdfcm9sZTogZGVzaXJlZCByb2xlIG9mIG9wZXJhdGlvbiB3aGlsZSB1c2luZyB0aGUg
T1RHIGJsb2NrDQo+ICAgKiBAb3RnX3Jlc3RhcnRfaG9zdDogZmxhZyB0aGF0IE9URyBjb250cm9s
bGVyIG5lZWRzIHRvIHJlc3RhcnQgaG9zdA0KPiAtICogQG5yX3NjcmF0Y2g6IG51bWJlciBvZiBz
Y3JhdGNoIGJ1ZmZlcnMNCj4gICAqIEB1MXUyOiBvbmx5IHVzZWQgb24gcmV2aXNpb25zIDwxLjgz
YSBmb3Igd29ya2Fyb3VuZA0KPiAgICogQG1heGltdW1fc3BlZWQ6IG1heGltdW0gc3BlZWQgcmVx
dWVzdGVkIChtYWlubHkgZm9yIHRlc3RpbmcgcHVycG9zZXMpDQo+ICAgKiBAbWF4X3NzcF9yYXRl
OiBTdXBlclNwZWVkIFBsdXMgbWF4aW11bSBzaWduYWxpbmcgcmF0ZSBhbmQgbGFuZSBjb3VudA0K
PiBAQCAtMTA1Niw3ICsxMDUzLDYgQEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+
ICAgKiBAZGVsYXllZF9zdGF0dXM6IHRydWUgd2hlbiBnYWRnZXQgZHJpdmVyIGFza3MgZm9yIGRl
bGF5ZWQgc3RhdHVzDQo+ICAgKiBAZXAwX2JvdW5jZWQ6IHRydWUgd2hlbiB3ZSB1c2VkIGJvdW5j
ZSBidWZmZXINCj4gICAqIEBlcDBfZXhwZWN0X2luOiB0cnVlIHdoZW4gd2UgZXhwZWN0IGEgREFU
QSBJTiB0cmFuc2Zlcg0KPiAtICogQGhhc19oaWJlcm5hdGlvbjogdHJ1ZSB3aGVuIGR3YzMgd2Fz
IGNvbmZpZ3VyZWQgd2l0aCBIaWJlcm5hdGlvbg0KPiAgICogQHN5c2Rldl9pc19wYXJlbnQ6IHRy
dWUgd2hlbiBkd2MzIGRldmljZSBoYXMgYSBwYXJlbnQgZHJpdmVyDQo+ICAgKiBAaGFzX2xwbV9l
cnJhdHVtOiB0cnVlIHdoZW4gY29yZSB3YXMgY29uZmlndXJlZCB3aXRoIExQTSBFcnJhdHVtLiBO
b3RlIHRoYXQNCj4gICAqCQkJdGhlcmUncyBub3cgd2F5IGZvciBzb2Z0d2FyZSB0byBkZXRlY3Qg
dGhpcyBpbiBydW50aW1lLg0KPiBAQCAtMTEyMywxMSArMTExOSw5IEBAIHN0cnVjdCBkd2MzIHsN
Cj4gIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+ICAJc3RydWN0IGR3YzNfdHJiCQkq
ZXAwX3RyYjsNCj4gIAl2b2lkCQkJKmJvdW5jZTsNCj4gLQl2b2lkCQkJKnNjcmF0Y2hidWY7DQo+
ICAJdTgJCQkqc2V0dXBfYnVmOw0KPiAgCWRtYV9hZGRyX3QJCWVwMF90cmJfYWRkcjsNCj4gIAlk
bWFfYWRkcl90CQlib3VuY2VfYWRkcjsNCj4gLQlkbWFfYWRkcl90CQlzY3JhdGNoX2FkZHI7DQo+
ICAJc3RydWN0IGR3YzNfcmVxdWVzdAllcDBfdXNiX3JlcTsNCj4gIAlzdHJ1Y3QgY29tcGxldGlv
bgllcDBfaW5fc2V0dXA7DQo+ICANCj4gQEAgLTExODcsNyArMTE4MSw2IEBAIHN0cnVjdCBkd2Mz
IHsNCj4gIAl1MzIJCQljdXJyZW50X290Z19yb2xlOw0KPiAgCXUzMgkJCWRlc2lyZWRfb3RnX3Jv
bGU7DQo+ICAJYm9vbAkJCW90Z19yZXN0YXJ0X2hvc3Q7DQo+IC0JdTMyCQkJbnJfc2NyYXRjaDsN
Cj4gIAl1MzIJCQl1MXUyOw0KPiAgCXUzMgkJCW1heGltdW1fc3BlZWQ7DQo+ICAJdTMyCQkJZ2Fk
Z2V0X21heF9zcGVlZDsNCj4gQEAgLTEyODQsNyArMTI3Nyw2IEBAIHN0cnVjdCBkd2MzIHsNCj4g
IAl1bnNpZ25lZAkJZGVsYXllZF9zdGF0dXM6MTsNCj4gIAl1bnNpZ25lZAkJZXAwX2JvdW5jZWQ6
MTsNCj4gIAl1bnNpZ25lZAkJZXAwX2V4cGVjdF9pbjoxOw0KPiAtCXVuc2lnbmVkCQloYXNfaGli
ZXJuYXRpb246MTsNCj4gIAl1bnNpZ25lZAkJc3lzZGV2X2lzX3BhcmVudDoxOw0KPiAgCXVuc2ln
bmVkCQloYXNfbHBtX2VycmF0dW06MTsNCj4gIAl1bnNpZ25lZAkJaXNfdXRtaV9sMV9zdXNwZW5k
OjE7DQo+IC0tIA0KPiAyLjM5LjINCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5o
Lk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
