Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C66DCEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDKBPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjDKBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:14:53 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3D1998;
        Mon, 10 Apr 2023 18:14:28 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJ5iRa011759;
        Mon, 10 Apr 2023 18:14:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=lVFu5mih9aQoKSJjd6n4lq5n1nz+lY1fyUBEL1yQhDI=;
 b=XS04kPOETMH/6YIJbexdYK+wEdSY9cpL9r0tjJFOzDCkZF2/z14+txYWF1vZexsNuIg0
 X1rPppSlQujfTxjeVn1tMXIIZZNW21GOq0ply1u80dwX2shfCqmB9jI3M/FH6WsIxeRj
 Qmi3c07Sk3pIygmqGszKJ1J45tSq5G1vRL5AvuUyGlRMnTPdLCCzUEd5zvoolp95M9iy
 /4dQiJ98ON28jx0GucQprFgwcyccpdHxZsDDJwg8xcgJu0lJ4vJ9qZqQjpkAmbWwlHy1
 9hdGIpjUysI6rXbEDHCZ0WcE3aYzb74YZL4XGJylsBySqvmWBzfqaJKFdG3e4bwAh27O hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pu76vu768-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 18:14:07 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7EBE8C0278;
        Tue, 11 Apr 2023 01:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1681175646; bh=lVFu5mih9aQoKSJjd6n4lq5n1nz+lY1fyUBEL1yQhDI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BKundpy73Yg3Jh5ps8kKRjk6/gTmIAODxKuzdjzvYm1NtZrMBqERamGBoT3pxYYhT
         awgOAa9yiL/vkUrE+e4q/nbROuoFxsgHrGNm8G3QRWrv2Gaud80VkKqNMSPL/wRhXo
         IVsfRBOYa5MPHUJT+g10Eal7XSmM8D5cluEEp3DerEPwp9BumKbhet0y0xiZUF7LeW
         JO2D9hhGmr9xJFQoC5O5zyicD3N1C+GvOMu8LTqyDA0DMs3RiS6HtoQlxUvYfUmjHc
         5bJ0mxr7HvWdp5id1llJ+30LtTDnlGQm1Vr1QDRdtA0/Ct2pq48ZKvlSyPLgAksr5p
         RYVBPRyo9/uUA==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3E683A0087;
        Tue, 11 Apr 2023 01:14:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7EA278017C;
        Tue, 11 Apr 2023 01:14:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Tr4TkIMS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e91rw3AbEscYMcrmQbVtE0j21NNtFSXONM+yGJQT+4DlWBbYB5+8PATfMR8qaXttKkmKpxB3MFxjPvKXu28/+yQf5TLkoJHR4AK/G30/eYeEe/NO0Zs3hJlNdtrG8jbtd7hKFrdSDj7lIECXz7oya6Nn3LQcM0nZN7xkb9Sc8eedJdLsgbXFwvGFZupiXj7LoGffL+efcLZNMfM8Fx4k+5y7KY2lSqKlTD+vGTl5JRFyHb6zIBjiFZvfK/xe/Dzqp8ICLR8Z58RAWqw+t52kKo2PvUEZTlCMoLEquQllcYvNGOJSGhgyUYmFthRIn5uw3vg/Jw0ss5LrmTaMZdH2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVFu5mih9aQoKSJjd6n4lq5n1nz+lY1fyUBEL1yQhDI=;
 b=Od7xiSehEg5EI0Qz+k012lwCCz89ixduXXqVqBPXxrjzs5jDaX03yR0cJjLrHFB9Tzzvd9Yo9wmgOqCVMoiu4vSChEI+4Wr32XPfEDc4kEahg+A1TLkEt8UiP3w6O7UcWPZc2hMEJ0Hw5yhHFbrLEko0tywU9dhG5/nELNA/38NirsIQadCwIh3mkzKvL7k5YjIDp/nBtXJuI4qVyPQd6fNaEUxF9+XJVvuZEpmEUeEgZ+q8JXSNgh7q0rwHBSo/KzHzy0ByXCRo8BAVu1SYd0wmH0OKJAwPLlJYHxvEwvPl0nm//Yhf14/CHi7E11C4VbJWEMrUqnqm68EOZYHSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVFu5mih9aQoKSJjd6n4lq5n1nz+lY1fyUBEL1yQhDI=;
 b=Tr4TkIMSHMJBQ6eJAG5V1HeLeNni6uYKJhxWrO3VhqI6vTmEgp+RScUzwrVNxKa97oQKYrdInS51MESBuriFQvzMK13+zu5gOS6urgCftnM+Pxxx5fxMoGfZe4kWVqdGg4AjXyZ17ED5/vizEnNoQGvQ6nslb+m9Ycfziq3/Ok4=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 01:14:03 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::a6ef:a9e2:ad28:f5cf%6]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 01:14:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v3 3/3] usb: dwc3: gadget: Execute gadget stop after
 halting the controller
Thread-Topic: [PATCH v3 3/3] usb: dwc3: gadget: Execute gadget stop after
 halting the controller
Thread-Index: AQHZbAMBuEbRzCqoCEefP+qWWO7HZK8lTcUA
Date:   Tue, 11 Apr 2023 01:14:03 +0000
Message-ID: <20230411011400.ukcr6khhkzi5hkac@synopsys.com>
References: <20230410231954.437-1-quic_wcheng@quicinc.com>
 <20230410231954.437-4-quic_wcheng@quicinc.com>
In-Reply-To: <20230410231954.437-4-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|MN2PR12MB4439:EE_
x-ms-office365-filtering-correlation-id: a2020e18-e002-4cd8-ad2c-08db3a2a0a47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oX5vrSKb+e5MJGN0EPtTbYzD1IattGKcg7SZllJHcfyFDx/RdO+wr+5kgVCcPwd/MCfFZUgkVfnqJSIuhjTMc6wBloyZHelA+a7JwJYS38Yyz8fykUgxobml7BTnj6NvRk0P65e6lbpkcg63qmKhn9uzVc4EXmI/0100bOLkM+vp0cbhSF2nJppaDC974e3BPEf2v3nj1RzhkBHLiN8lgftpbxTuwSrNcu7XY/SFc4k1Gs3Qr4Up3UyloVQAWyHWv2L2ARrPCpWkhAkJjwlPFeg7ZTfskAFaDYfjmrF5XD/RiqZYR7NzcJ8FYXisAaH6pD0lwnptW7NY8Edz+AV2PQhVh33UF9hmZ+0V+1Q1KHhFhMWfiwl2zr//gDlruVxHwvxDwdRyv+MPfGsCIl6+qAwHAritH0QT8r6YR20i8XxAFfx0NyqADRDPO3TCJLpuiqSzAmOnZF/qAmMq150iKADhZ2KMSJCngVg70a63zqWRNbhdXXqk07D4mhJzbtFNF2qRlL+a623QBysua4H2+JZc20P5lUyJ1Zvy50mSYbs4+Io4PhNi0Nb6AZ5eBf4HTIdI/48eTDkcT3Cc293ZeTX9x2n/hXLcRciOu+EEDak22C/in+/Dg0kqzwJhFqf5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(2906002)(122000001)(71200400001)(86362001)(83380400001)(6512007)(6506007)(26005)(38100700002)(186003)(1076003)(2616005)(316002)(38070700005)(5660300002)(54906003)(8936002)(41300700001)(6486002)(91956017)(36756003)(478600001)(66946007)(4326008)(64756008)(66446008)(66476007)(8676002)(66556008)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3lMZDUrU003ai9jUElONXBOc0NFdWs1UndJTFVpZ1ZQeWQwak5WWlY1a05w?=
 =?utf-8?B?VnNUbzJ6NDJ1T0VKQWIyUmFST2ZIVXdrS1FZREFvY1ZrenlyMUN1Q05IRFJZ?=
 =?utf-8?B?dWxzckdpSVRkOWJjVkl6YkZaTmoraldRZG9lVkxNT0dLT2ZWQ2g3bWduelhZ?=
 =?utf-8?B?alFRNEVBRmorZUFxc2RuS0xGQkhoSy80R3hYd0V6ZjVNSnBWZlM0K2JCLy9l?=
 =?utf-8?B?S3Q3clZjYTljcUtrb3l5QnNBN2RhL2x0T2t6N29CaVR0RVltUWVkdmRPU2JZ?=
 =?utf-8?B?RGd0Z1Z4NlV5bXd1dit3ZjlYVjdmY3IzMVN3UUFpNnpuZjFhZC9scGx3R2hw?=
 =?utf-8?B?QUxOWWk0V2VtTzk4YXkwMUxnejRUM01OY2s0UHNneEpzYUYySWJTRDl4SG80?=
 =?utf-8?B?L1UvVEtsamFXNXRVZDREK0JtemJLWXZ4ZHF3Z2ZCa2NwaS80RkpaaVE1QmUw?=
 =?utf-8?B?L3VTMWRQQWhLOUR3d1lxYnUySXRuK2J4YThaUitXZkJKMzFpZUV6dm1YOTN0?=
 =?utf-8?B?Q0JVK0poTlh6M0JuQ21KWFk1T1VJcytnb2VLVCs5Yk54OGlRSzY5bGlkcFI1?=
 =?utf-8?B?dnd0UmtMTy9Udy9wMGFIVHYwMTByVWFERTZtRG55OWZtSTRidXFqalVyc3Yr?=
 =?utf-8?B?UEk1TmVid29qSFZJQUZzSjQrOFNOTXNWVnpYTjVWeElHOEFTR3Q5ZlArSGdG?=
 =?utf-8?B?VG1PSzBFdzA4SGgxNDByS2tFVGE3RTNITGNoSzJRSEV0R1RVajZRa3o4Zk45?=
 =?utf-8?B?amtNL3Z5bE55WEcvNEd0VXQ2dk9QWUFSMVBBTE9MRkdpbmc0azRZUEZJUndw?=
 =?utf-8?B?b0NBMnB4T1JBbHY5TnVKdE14aSthdXFGRFNhWW9XRE05YXZ4THNLTlk2UnJK?=
 =?utf-8?B?RHhadEtoemxkbDF1VFd1YmhJOXFzRHdsbU4rOCs5cVR1Vmx6TXhyWmJCYUJB?=
 =?utf-8?B?QktpaVVwczJYTkpnSC9nSURubU54d0RjMldFdzYxUmU4QzhVV1h6MkRKbS9R?=
 =?utf-8?B?L0NmeXdVQ0NZYnQwaUlMTk1VVmVJTW1nRWpmM0FIaWwvMTdCaDdOem9OS1J1?=
 =?utf-8?B?NERzWThNSDQzemRobjk1dE5oVTlzM08yZDFlSFVuVGZIK0xWY0JHTFM5QnlW?=
 =?utf-8?B?ajZkUldUcUN0andFK3cxLzlkemgwMjN6WHNOM3dSOUtiL1FUK0hnMktvZ3Fn?=
 =?utf-8?B?Und1YzNrUUZHYmxzUmNmcFUwcWxJUk5Ea2JhNERGV3B0SWxHZmdubWVJYXVa?=
 =?utf-8?B?UEtHL3pPSmE5azczb2Z5MlVpTGZKUHFINU5SN3hlUGZzRWFNRXZacmxCdmll?=
 =?utf-8?B?SWdJbmFDZHg2aG5NSm5oSlY0NC9QMW5VWmRITDVOcW9yclU4MVEvbE4wWHhQ?=
 =?utf-8?B?c2V0Qk1rQ21XUDNaNlZuSGhxN2hxQkttbG1zd0Q0TnFnSEU3R3VUejIxR1cv?=
 =?utf-8?B?TVlWOGErWGFUNkZ2dlEwQW1SOVRRRC9ZZHNKbVRlM283dHJiUjRlQlJpQitX?=
 =?utf-8?B?SWMrZ3c3cVppZ0xkZ3gvN0M0OURDZ1dJZjFUU1BaL21YTlFnaUkrb01lSEYv?=
 =?utf-8?B?VEd6NjVSb2dwRTdWQllKY0FzNWI4S1JQc3JzeVgrVit4WEtvNTVEcm5ZZXJD?=
 =?utf-8?B?L3ViOHhnRzVrTGJORFZpeFpuSStZUFhRdXJOYWFiR2Rnbjg4ZWE0UDlBUksr?=
 =?utf-8?B?d2ozS3p6NFU1VS8rM1UxOWR3ZlBFNWZORUZXSmRjMkw2TjV2ZTVUa08wbDNX?=
 =?utf-8?B?L0dRb2VUZlV6Z1hRRjJ0eHFHQzBqdGVWcDBiV1BEQ1pseXRRZnFjbUI3ci9L?=
 =?utf-8?B?eUUvbGJkQ21CbG1QU3lsMVdlWDJad0ZDejdHcHpMNGpnTjQ3N3l5NGkzOUlp?=
 =?utf-8?B?MnppV1lycHpjQktETGlSYm5RU05VNElnMUtvR1h4d3FuV1VUL0Zvb1M0Znpu?=
 =?utf-8?B?NzRzQ2hwdXRZbmZ0aHZtNlZ6OUlUSUx6eEhWMktOelBQZVI0aUk1S1NmQlF6?=
 =?utf-8?B?T1B1Vi9LNnNsenQ2ZFg2K0ZUQlRnbDNUdjg2dFFHa01aTGJHV2htaEgyRDly?=
 =?utf-8?B?SGM0KzVwMzZEUnRrb0JaQjg1UmNFQjZOcmordm5Sd1ZxOW12M3JFbGt3L2Rj?=
 =?utf-8?Q?B0Ms0I7GoQQPo+ADV78yEOTf+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC2F5F7CAE487F489D2D1BBDD1C24866@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /yEraZq8140fGIHJQOf6iRN6yVfJPd3N1i4Vzr4HJYKaA4naMrGS3i3aElNI/kN3meSTgDbv5TFSiaXqJmS+j2QLGv5U1tBydSurTon9wTYK+10BQ4C1trwNKJMM9MZ26REFEFV6lDFdovZ0RlHQf0K7OraT+kpsWdvFBzbiKBUxt9aNsWmaFhWTlHseyMWeaKst/HVoUy5kLmPY8wti2EJ88xHAxWib9OyUpWfBk5Tqee3SrnA82yFSejDkn6JsbvASzI8RYeqr9oo0AX3YfF0XCL2vlDs3lWuMjtYg6Y+dSiFTsYiLyjHaMXIjwtboQb3GcL6OW0PfVR6zCHGRkoyRl+iQxWcx53IRorwQKnRHRtGaHtEffJ4RurPDjOIWkbV9hV8ZYNYI3trXzx7CV2Wqml+e3zzi3bnNA5PVVwCQbRgXRxDrhqUtSdQVV9mxuLODkGoRrwXDf+xSJ9s9qKg+5cit+HhxhrhsE5cjEtMYjFtR8+NdG7mpbazKRPXI3OGrVoZ21Vcjd6I3gsAK/qd2kuhpfkd/Vgk2n6IXZbA//bUrDq2SYY5XWs6khRhxtq+PSWMrfz8GWOPCbJ4mrpaZJ63kYVmA5SG4VyTmyxhq4fOFJwCXmeJgcC+DptbxzJBZs76SuQm84QN/i+78Md208leQ/Koxb/RUCInz3Txf2IRcYRVBKBMaieh4PqTw+NQf9nq/VXqV0nV/+52qbRRZgiyZFyRswLWE1L3w8I2XlDRDmNYqbWUrsqOYB13adZ3ORXfkcOzndXSJ3PByHx9gQDLdHNlsLpQIinKtpaygXtYhk3648Yk6VsGZ1uLL3pdDTav4nzEyJQYEO7OXux5o5juRF5vOmGRgtKDXycQOvm4bEUalfRLhbQQgn91YtxfEtJaHgDhp7nHlt44R4Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2020e18-e002-4cd8-ad2c-08db3a2a0a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 01:14:03.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLHYce7W1OdFXSNxt9BllFDvSI1+L+qZoP+EIjiCNmGTX9Z37z+FTFmrESCA2+NxjaqiqeYgZto2Utgy6mIQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Proofpoint-GUID: l2kYArExmUMvm1hnbfEeevUmojLtLVzV
X-Proofpoint-ORIG-GUID: l2kYArExmUMvm1hnbfEeevUmojLtLVzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=782 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304110009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBcHIgMTAsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gRG8gbm90IGNhbGwg
Z2FkZ2V0IHN0b3AgdW50aWwgdGhlIHBvbGwgZm9yIGNvbnRyb2xsZXIgaGFsdCBpcw0KPiBjb21w
bGV0ZWQuICBERVZURU4gaXMgY2xlYXJlZCBhcyBwYXJ0IG9mIGdhZGdldCBzdG9wLCBzbyB0aGUg
aW50ZW50aW9uIHRvDQo+IGFsbG93IGVwMCBldmVudHMgdG8gY29udGludWUgd2hpbGUgd2FpdGlu
ZyBmb3IgY29udHJvbGxlciBoYWx0IGlzIG5vdA0KPiBoYXBwZW5pbmcuDQo+IA0KPiBGaXhlczog
Yzk2NjgzNzk4ZTI3ICgidXNiOiBkd2MzOiBlcDA6IERvbid0IHByZXBhcmUgYmV5b25kIFNldHVw
IHN0YWdlIikNCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMTUgKysrKysr
KysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA5MTc2OGYxYmRiYWYuLjk3MTVkZThlOTli
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0yNTY2LDcgKzI1NjYsNiBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCSAqIGJp
dC4NCj4gIAkgKi8NCj4gIAlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycyhkd2MpOw0KPiAtCV9f
ZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+
bG9jaywgZmxhZ3MpOw0KPiAgDQo+ICAJLyoNCj4gQEAgLTI1OTYsNyArMjU5NSwxOSBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAg
CSAqIHJlbWFpbmluZyBldmVudCBnZW5lcmF0ZWQgYnkgdGhlIGNvbnRyb2xsZXIgd2hpbGUgcG9s
bGluZyBmb3INCj4gIAkgKiBEU1RTLkRFVkNUTEhMVC4NCj4gIAkgKi8NCj4gLQlyZXR1cm4gZHdj
M19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiArCXJldCA9IGR3YzNfZ2Fk
Z2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gKw0KPiArCS8qDQo+ICsJICogU3Rv
cCB0aGUgZ2FkZ2V0IGFmdGVyIGNvbnRyb2xsZXIgaXMgaGFsdGVkLCBzbyB0aGF0IGlmIG5lZWRl
ZCwgdGhlDQo+ICsJICogZXZlbnRzIHRvIHVwZGF0ZSBFUDAgc3RhdGUgY2FuIHN0aWxsIG9jY3Vy
IHdoaWxlIHRoZSBydW4vc3RvcA0KPiArCSAqIHJvdXRpbmUgcG9sbHMgZm9yIHRoZSBoYWx0ZWQg
c3RhdGUuICBERVZURU4gaXMgY2xlYXJlZCBhcyBwYXJ0IG9mDQo+ICsJICogZ2FkZ2V0IHN0b3Au
DQo+ICsJICovDQo+ICsJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAr
CV9fZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3
Yy0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBpc19v
bikNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4N
Cg0KVGhhbmtzLA0KVGhpbmg=
