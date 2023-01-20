Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE24676059
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjATWok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjATWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:44:38 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8513DC7;
        Fri, 20 Jan 2023 14:44:32 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KM5OwG012012;
        Fri, 20 Jan 2023 14:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=bw1Bum2QUkFglzBi+KVwqzECLgvgH6uLbbR5/gv03VY=;
 b=SjKtw8pWP7KcF66+D5cpT2ML3E1Z740uATyYJkIe+/hhlgbGV1hkGxyOX+w/1dbsOeQg
 n1iokDwjr01KJKl6g16T6hj5GJyHhSqCGjYfTTn/BcrpmNBHBbVfjiHp8J/3PNHoeALR
 P+NCuzryIc1nbOG+tSVl+ks/17gjPiikBCEW2vfSNdVCB7gaevvi6FbUVBN61xMCQopJ
 D3X8VPNJpgjh5JCi+xooC+t20ZqIeNwOzZR3icCNPxueDdEacr2ahRkdZhKllJ+qqIyR
 r7rd1bg6pVeX4rlfkpLkgIcpQmXJFE1j3CDUhMID3H6rneIymlfovv+zPz1w/qwASKhX bg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3v9ssksd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 14:44:19 -0800
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B0B9C098D;
        Fri, 20 Jan 2023 22:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674254659; bh=bw1Bum2QUkFglzBi+KVwqzECLgvgH6uLbbR5/gv03VY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NVTzfOsu2PMqLrjzEQuv6YMDZ5OMAI8mODiXPUzQzMwHu+Q+wCErKVT9dfgg5AT1M
         QIzlKNeW4KzFB16gL2orT1oOqQCxONMlHB3QCKOI17yTeh9bFEnW/L2rBr2djRmwMG
         ny2euy6wZt/gAgyj83e+8dOD5ogH7osHcGiyvOqPCWL3qpayMTUvFu+NB69pKxl5Vr
         5i5PZEAOm6nOwPOJR1AVuPZx4aVtUGAjPCBsfotFNc0bR7PaPgRP3J1BXtMj5+ytW4
         wU+MzLiUtaPLJGfgoeebZN1fX4dkvIAqtJcD7iIksu0+dFrs5+6eUl9f2NnaZEaJRc
         /2AU/pcMV+mYg==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9DBF7A005C;
        Fri, 20 Jan 2023 22:44:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0277D800DF;
        Fri, 20 Jan 2023 22:44:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EiaiHgft";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU9+VWSFI4WRxB6FoucBBdjA6n8j86MXmMdHZnGqutTt8T/DX4uHTDTwI2nm0wvpbQaaxVvUh4fW8uGiz/2UqNusRLg+aT06ZF0HFBZs9h4j2AyOcAkUya3852utxb3NvhhcSMTFtWJyn7LuCuU5govh9Wf298CksmLqR7QDDGABRLFUdeNoNAcfVnWf7w62rh7IUQaGB/neeTZGAKJKDbwJVeIRjZ3Q+miDf/7YoHYkGaaeSDgzc5d+jr8kNZIeQZDEQUILQAkZMC3zPbC9zhcXpIo4my+NN+/ZZn4ksXS20qQJD5vsxKIGHn+jzqTODeiwDJK2Oy8cnibzCVoknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw1Bum2QUkFglzBi+KVwqzECLgvgH6uLbbR5/gv03VY=;
 b=ICKp7n/WpktVdDPijfS8NmNYUp0J5/ooDs9J36oxtbicbNk4TBegQrAo/worYcesqwxrDEQEtibMRUZpA6gkGuQIVblc5F3U68rWx2eTdsaPKuPybo5+VPk3hF1IX0O3Lagv4lBvALpKJ408ZUwQj3gbW5JCL21t6oE+d3U66vjMfaoObYyzgIayK6ofnkFRzuenomOkdtJ+4byCXqvykjuDiagKb/KTPvKcCqzeJ07emkT041ydBWsyEviX2hKo1W9SrraEn8Ri+DvnEXzvNqftHvicMN+eyhCfWrdSJLkU9UusZFWPGlEoXXkg2qUNmc232/OgyAH8FLcmzEFtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw1Bum2QUkFglzBi+KVwqzECLgvgH6uLbbR5/gv03VY=;
 b=EiaiHgftmxCD9TJFBG4Mthr2kuZUhr8afkj6yYp4guQSUXlZmWVMtNDLjSSmrnn8SfA5D5sOw68+7ENS6NaGV0eS08zD9qkEU5pIVC8dS7cM22SFL+fPm5fQNJqu7IdkPSXbrSKkI7IHf4l0L2vQUGGvj8BtYuJg8gz+T0CaeWM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 22:44:10 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 22:44:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Topic: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Thread-Index: AQHZKNZ01nzPNqP4IUaLkP7OVwXfx66k6muAgAAojICAAXEUAIAADDCAgAFfeAA=
Date:   Fri, 20 Jan 2023 22:44:09 +0000
Message-ID: <20230120224400.77t2j3qtcdfqwt5s@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
 <20230120010226.wjwtisj4id6frirl@synopsys.com>
 <91fa86d8-f443-db13-1544-73e2dd50d964@quicinc.com>
In-Reply-To: <91fa86d8-f443-db13-1544-73e2dd50d964@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB7511:EE_
x-ms-office365-filtering-correlation-id: 2ea37a7b-8349-480d-21b7-08dafb37d82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SI3/7DoYrEujeK1sQYXxfkd6dwEm47wEDMdNS+ETZXCNVVVSKJ4V5zyW40/nTAYrj3shzjA22uxfkzvoZxpQNzjYYRJQGVQ7pWr0Z0sAmSvEyRBG+W3n1BVwAykAzDZ2afwi5AMAoL8eACx0jBQNkLVJxNJEoLwsb5g5Pe2c+0ENy9er6Y6zxTd5VtpppIDMdVeoq8pTCg42Er7elIc6P9h40EyDkw3gexSALTt4439SU37Iwb6kBF7sGGY3WE5K1kaVk9aU0l52o9yHmSEq37A5EbhxeG1/rYegzbR0zaRKW1nrSR4YEkdKvxutlU5U/Rgn0pEhy8w5pb4efbbiZpMEIsXAQ6IXWAk8zvd8vr7RUI7KxMGOjZo2T2Rv99ldJ/xFDAaeXioT5MbFkwBZUA2TdRBOzsNh5WZIQvrVhecjH3ZklVWLdokGjcsVr+pOot0lLUod28SDQ8vtQ1i8LjiYgHbecfHtHUfAHckOHgT6ueibS03n0lYetyX3+LoedkDVWseKd/5j7H3sgnQ5771rCFGOACob9K2BU1EBc+5MsHD9LPtXyQMSz2SrpmYffe4BNr1cBWlYviQHMfh8X7XSw7e9UXqOQGSfP/o/DUy7gKYALuopgVb1nW0Mnmsft2NaZJjuJbzoItNuyuPMlRwT7ygmvr/zLvljldXyN1DJ1i9hQj/YZ/09bFUEncW/VT7jmmjVEjcGk4DNzWOFvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(8936002)(38070700005)(54906003)(8676002)(6916009)(38100700002)(7416002)(4326008)(26005)(2906002)(6486002)(83380400001)(186003)(6512007)(316002)(76116006)(478600001)(66476007)(6506007)(41300700001)(36756003)(86362001)(1076003)(71200400001)(66946007)(66446008)(64756008)(5660300002)(66556008)(53546011)(122000001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhCbGtxNUl0a3B4dmR5TWxpZmRIN0xKQndHc0JJUitpVWhjZFllN3hqNUpL?=
 =?utf-8?B?dWRmTndiNDdueVhiWkx4UXduOTlLdWpHUjZWSmxqUkJPODNiOE00MmRXZ3FS?=
 =?utf-8?B?ZDU1M001Vm9XK2tZa1kzSzlldlFaUCtnMWx2YXBDbVZNRW1ZVWtrZ1NMWnFQ?=
 =?utf-8?B?NmpMNnRtU2lWUERjTC8zaUIrVi9CS1k3QWNwcDduWjE0QVp1TWZ5MlBBQUpn?=
 =?utf-8?B?akRJR3RrN05sb3FJWGw1U05WWVEyMHh3c3h4aWlWWmVSeHI1TW85dm5UQUNB?=
 =?utf-8?B?WkpDaGpSWkkraWdWQWdEcHBseHorVFlQeVZFSGptZkg1QTRnT1JXbzBxdGQv?=
 =?utf-8?B?Q1ovQVRUS2pNcG5STnBZa1AzaW1BU2xhZEhTRjdHWDREVXJXWUVFeGpOTFFJ?=
 =?utf-8?B?VzV5QmxGQi9NYUdwNWdzYWlhVmtEemQ5T3FBbGNFMmdKTk1aZEkzS2JHZVFT?=
 =?utf-8?B?TmhlT2lEZmprQ2tYNy9pUVZQZnBGWHdBRXhISXkxNnJLT21iL3dKWVlId0Za?=
 =?utf-8?B?V04xNUVYWjFpWkVUU2pxK2ZXV3cySFY0ZEdRL1RQbUgzajIvSEI5NFFnVlpE?=
 =?utf-8?B?dHJvdCtFd0paUnlzNkVveExWSCtpUFBNd0RXZVhjeTN1OTRVTFVneTViVEdJ?=
 =?utf-8?B?Qyt0aU5DV2c5aE9BemJ3eWVqRUpLRUpmSXhxdS9yQlFRbmFmUmNBUFk5WWJz?=
 =?utf-8?B?R1JaWEJIRk1VS01JWFg1YjR2aWt0WHpRWno0bjg0N1ZhK2t3eCtmeStZazFL?=
 =?utf-8?B?Sk1obkcya3pZZlZMMUxXeHJhL05jazUxNEo1RmR0a2RNSTBiTnVJOEh4czFO?=
 =?utf-8?B?b1g0NHA1U0tSb05aK1AzdkxzaGJBWlh0ODloeGdVa3NqbVJtWWtES2hob25T?=
 =?utf-8?B?UUNTR21sRzNIR2d2anN4ZWRjZWhDS1k4d1A4TUtoODR5QXdLeWxBY1M1aUdq?=
 =?utf-8?B?MVZuV2QxMHM3dUZFWnN3azkwMERDOTN6dGN5WDVYZ2dmQVpOZWhZcWM0WUF2?=
 =?utf-8?B?ODA4VjZReDA4MFQyTHQ2V0wzT0FZQ0plUEUxSnZvTHp2a0RCWGxjS2RSZ2g2?=
 =?utf-8?B?OHEvS1RsNzh6RlpLYlF2Y2J6Um1hTlU2WDBmUktBYjlKNHFIQWI4bHhJWlZZ?=
 =?utf-8?B?TC9CUmNOTTUrVG1MRGN5bkd3TTBHMjVBaVEzaitQZW1mOXpQb2hRZmRXa0lm?=
 =?utf-8?B?aWoxTCtSTERYMlllQ2hHeHBSL2FqREF4dkVlMHoxSi9rSzdCbVd1a2o3REhL?=
 =?utf-8?B?ZHlHOHNpMEFMVnhyNmg4Z2ZiWmwxYjFDQUE4RWd1VTFwUVczb1VGVHF5UW1O?=
 =?utf-8?B?bkJMN3A4a3F3QjR3Q3hPeXQvQ2I4SzBFd29MWDZKY1FmbjNoaXVyYXE0Sjc1?=
 =?utf-8?B?OUQxbzhubmhzM0JwMXA3eU41K3lybzJiUjh4Y1g0TUhhbmh5RXhRaDhrOHRz?=
 =?utf-8?B?Sk8rd1phUVNoSjZqV2VhQU9YWDI3UWZGdEhwNjEyb1BBdDNsRTVaNXBObUU3?=
 =?utf-8?B?S1BWVTRoYjc2WXh6dnJzRHA5bDhWd2hGbEo5Q0g3NXVoWE8zQk9pM3d0L3kz?=
 =?utf-8?B?N2FHOG1VWWlDcDM3RHZnZ1p2SjlxRndUb0w1ZDFqTTBHOWYyMTRqZkZqVjBS?=
 =?utf-8?B?T3ZqcjFIeEpBdk9QRzY4anlJbHcxRHF1LzFBenEzTUtKVmc0REt3WWFSREhw?=
 =?utf-8?B?cEFpQ0dURk9zK1R2R3J3RFZaWFdPNmNRRVEraWVPb1pPSDBHblllT2V6dkVh?=
 =?utf-8?B?YWRDeUxRT1k0L0p3VDkwM1U4Ym1SSGNOOW9oZlhPS21kYUdKOWV6MnBBY1Jw?=
 =?utf-8?B?eWJuYWI3UjdPY3YrTUFWcXJUeTBnb1E0K0RMNElCNUVsSG41V0pDN1JGTkU4?=
 =?utf-8?B?L25kWlA4REZhMnc0alQzVEJXSURFZzd0ZTRJaFRDdk9aMkZ5MXhBQkpDRkhv?=
 =?utf-8?B?ZnpDbnQwMlc2a2R1NmIrcklYb093Mkh4RGYycG1Zeml0RTh6bW03ZDVJQUR6?=
 =?utf-8?B?eUVyMXk3VTYrQ2NOTldrcHN2Yi9DQ0w1U1BlYi9Od2dIenRkZ2JXUEJmYURC?=
 =?utf-8?B?ODlhczJrUTMvVkdQVi9iRzZsazREa1JvMnB3TW9BMmhka1NJcGgvaUM4MnB2?=
 =?utf-8?B?KzJpUUJFaDkyNXZ6N2ZwT2ZIMnNZVFU5QXUvS0JVRjI3S0xLTWdsNGszbnpP?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9357676D189052448BFBEE89A7DF8EE1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WmVSTGVta253RkhEVU9hbXVxVDV2aXFFZXl2dFlvMzY1VHNlNFdFN05kQlY3?=
 =?utf-8?B?ZmNYMUczMitjU1NvL3dqYzdOVXROS29rRkppOTFkY3h6NWpWcUdPdDQ2dWxV?=
 =?utf-8?B?RDJxRTAxbWY2bzdiWGV6USswYStESnMwMURHRnFYZmp3ZERnemNzNE9ZL1lE?=
 =?utf-8?B?L1h6TE00WStFbHFyTWE4Y1lRNk5qalVPVWRCSU5PcThvbi9EMmxYbitmTUdV?=
 =?utf-8?B?WC9rQThmWHIvKzFsOFViM08xOWJHKzdZTm42UEJLcjI4ZUU2VmJyTFlIL3BU?=
 =?utf-8?B?NmJDL2ZBWWhoa2NROEtvdGRQMWgyMjB0Sndad3Y5YXNkTi9VRFpnNlpnano5?=
 =?utf-8?B?Z2FpTzhHZis3bDcrMFBhcGlwRS9SQXFLUG85YlhFWTJja3RPL1g2T1RNVHl3?=
 =?utf-8?B?Q3g2bVJ2TDlEcEVqdzVrMVRKM3JTczAydCt3cjlMb0NkN1AwYVplRWZUMjJF?=
 =?utf-8?B?OUg4eFdRdFprd3V0U0I0YmNyYzd5Z0JrekRhVExXNlpxTTNIQXlON29wWmxT?=
 =?utf-8?B?NERMV2hBdXI0OTVuNmtBckM0THNPUXhNT05VOVdxR1o5UEduMkprTWlNbVpy?=
 =?utf-8?B?RjRsbDBrRU11eUdwK1NtNUYvV2ZGM1BsNlF6TXZ3OGcybXlsZXhIMU10TnVJ?=
 =?utf-8?B?RGd6dGJrMnV3eVBqZ1BCVHJkVldyeGVpTTRRMHRCckR6UmEzb0xmRDlLQ3J3?=
 =?utf-8?B?OGlyUk9ibmYvYmlBMHFyZ2FBTDhoZHRiNVVDU0hhL0ppaHduUzFTT3R6QlZw?=
 =?utf-8?B?d3RlM3JQdnIwOXc4anJiWGkyM3NseUZra1RsQldZbnBTVkdaWFdXZ1FxYi9D?=
 =?utf-8?B?bE5oazNDLysyQmpNT2ZkMmZraUYxMUFkTDBzSWs1VUt3dVgrdHVjcnVrNWN5?=
 =?utf-8?B?aWlFWFhDQjB4RzR4Vjc0eC83Y3gyeXBxZDdldXZQWC9QNlJLQ2R5ZzEyTW43?=
 =?utf-8?B?NUZvTDY4azNNWjJvVkZTSFZhbFZickhnT0dmMFlacmpBN2tZV04rcnBkOTI5?=
 =?utf-8?B?QytKZnhwRGRQWWthb1U4ZnJtRmdLU2JQQk0wVHBzTGJtOFB2ajZTT0VMQ3Rv?=
 =?utf-8?B?ditQREFWQ3B4QTRzeWxFL0x6OU1RV0JTQWgrNGJhemVWc3ZNMnNuRzIzNHZz?=
 =?utf-8?B?TWtwUng2c09PYStTczkyeTVUVUs0K0VTVWJFOExDeEg5UFA3VmtNVDZPOGZk?=
 =?utf-8?B?L2JQejNoajZNdUJSWVZySUd3NUQyekRyRlFVRTZsVk9BdjQvZDA1K1ZTZjcy?=
 =?utf-8?B?SzZCZDFBZHU5RE1OWmVid2hRQzFIUVdJNmo4Z253T2MycTNHNC9KWDZ6RWNz?=
 =?utf-8?Q?2yskx35ho3bC4=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea37a7b-8349-480d-21b7-08dafb37d82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 22:44:09.4512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1oTIc68UCAz7OtIUen9/TRqpttsOr5HZwQD0qgjwsvP2Ckm9Wr0NjmIvCWqEDBUdIneVKh8E1vjMbtDFBcV41g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511
X-Proofpoint-ORIG-GUID: zbbaGSFXe5hZA7aIeQyfml2b49loLsVe
X-Proofpoint-GUID: zbbaGSFXe5hZA7aIeQyfml2b49loLsVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKYW4gMjAsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gMS8yMC8yMDIzIDY6MzIgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBIaSwN
Cj4gPiANCj4gPiBPbiBUaHUsIEphbiAxOSwgMjAyMywgS3Jpc2huYSBLdXJhcGF0aSBQU1NOViB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiAxLzE5LzIwMjMgNjowNiBBTSwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFN1biwgSmFu
IDE1LCAyMDIzLCBLcmlzaG5hIEt1cmFwYXRpIHdyb3RlOg0KPiA+ID4gPiA+IEN1cnJlbnRseSB0
aGUgRFdDMyBkcml2ZXIgc3VwcG9ydHMgb25seSBzaW5nbGUgcG9ydCBjb250cm9sbGVyDQo+ID4g
PiA+ID4gd2hpY2ggcmVxdWlyZXMgYXQgbW9zdCBvbmUgSFMgYW5kIG9uZSBTUyBQSFkuDQo+ID4g
PiA+IA0KPiA+ID4gPiBBZGQgbm90ZSBoZXJlIHRoYXQgbXVsdGktcG9ydCBpcyBmb3IgaG9zdCBt
b2RlIGZvciBjbGFyaXR5Lg0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCdXQgdGhl
IERXQzMgVVNCIGNvbnRyb2xsZXIgY2FuIGJlIGNvbm5lY3RlZCB0byBtdWx0aXBsZSBwb3J0cyBh
bmQNCj4gPiA+ID4gPiBlYWNoIHBvcnQgY2FuIGhhdmUgdGhlaXIgb3duIFBIWXMuIEVhY2ggcG9y
dCBvZiB0aGUgbXVsdGlwb3J0DQo+ID4gPiA+ID4gY29udHJvbGxlciBjYW4gZWl0aGVyIGJlIEhT
K1NTIGNhcGFibGUgb3IgSFMgb25seSBjYXBhYmxlDQo+ID4gPiA+ID4gUHJvcGVyIHF1YW50aWZp
Y2F0aW9uIG9mIHRoZW0gaXMgcmVxdWlyZWQgdG8gbW9kaWZ5IEdVU0IyUEhZQ0ZHDQo+ID4gPiA+
ID4gYW5kIEdVU0IzUElQRUNUTCByZWdpc3RlcnMgYXBwcm9wcmlhdGVseS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgZGV0ZWN0aW5nLCBvYnRhaW5pbmcgYW5kIGNvbmZp
Z3VyaW5nIHBoeSdzIHN1cHBvcnRlZA0KPiA+ID4gPiA+IGJ5IGEgbXVsdGlwb3J0IGNvbnRyb2xs
ZXIgYW5kIGxpbWl0IHRoZSBtYXggbnVtYmVyIG9mIHBvcnRzDQo+ID4gPiA+ID4gc3VwcG9ydGVk
IHRvIDQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSGFyc2ggQWdhcndh
bCA8cXVpY19oYXJzaHFAcXVpY2luYy5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jp
c2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDMwNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gICAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmggfCAgMTUgKy0NCj4gPiA+ID4gPiAgICBkcml2ZXJzL3VzYi9kd2MzL2RyZC5jICB8
ICAxNCArLQ0KPiA+ID4gPiA+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMjQ0IGluc2VydGlvbnMoKyks
IDg5IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+IA0KPiA+IDxzbmlwPg0KPiA+IA0KPiA+
ID4gPiA+IEBAIC0xNTc1LDYgKzE2OTAsMjEgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVy
dGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiA+ICAgIAlkd2MtPmRpc19zcGxpdF9xdWly
ayA9IGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+ID4gPiA+ICAgIAkJCQkic25w
cyxkaXMtc3BsaXQtcXVpcmsiKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkvKg0KPiA+ID4g
PiA+ICsJICogSWYgbm8gbXVsaXRwb3J0IHByb3BlcnRpZXMgYXJlIGRlZmluZWQsIGRlZmF1bHQN
Cj4gPiA+ID4gDQo+ID4gPiA+IG11bHRpKg0KPiA+ID4gPiANCj4gPiA+ID4gPiArCSAqIHRoZSBw
b3J0IGNvdW50IHRvICcxJy4NCj4gPiA+ID4gPiArCSAqLw0KPiA+ID4gPiANCj4gPiA+ID4gQ2Fu
IHdlIGluaXRpYWxpemUgbnVtX3BvcnRzIGFuZCBudW1fc3NfcG9ydHMgdG8gMSBpbnN0ZWFkIG9m
IHNldHRpbmcgaXQNCj4gPiA+ID4gb24gZXJyb3IgKHNpbWlsYXIgdG8gaG93IHdlIGhhbmRsZSBv
dGhlciBwcm9wZXJ0aWVzKS4NCj4gPiA+ID4gDQo+ID4gPiBIaSBUaGluaCwNCj4gPiA+IA0KPiA+
ID4gICAgVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBPbiB0aGUgYmluZGluZ3MsIFJvYiBhbmQgS3J6
eXN6dG9mIGhhdmUgc3VnZ2VzdGVkDQo+ID4gPiB0byBnZXQgdGhlIG51bS1wb3J0cyBhbmQgbnVt
LXNzLXBvcnRzIGJ5IGNvdW50aW5nIHRoZSBQaHktbmFtZXMgaW4gRFQuDQo+ID4gDQo+ID4gVGhp
cyBtYXkgYmUgYSBiaXQgcHJvYmxlbWF0aWMgZm9yIG5vbi1EVCBkZXZpY2UuIEN1cnJlbnRseSBw
Y2kgZGV2aWNlcw0KPiA+IHBhc3MgZmFrZSBEVCBwcm9wZXJ0aWVzIHRvIHNlbmQgdGhlc2Uga2lu
ZHMgb2YgaW5mby4gQnV0IHRoYXQncyBmaW5lLA0KPiA+IHdlIGNhbiBlbmhhbmNlIGR3YzMgZm9y
IG5vbi1EVCBkZXZpY2VzIGxhdGVyLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBTaW5jZSB0aGVyZSBt
YXkgYmUgbWFueSBjYXNlcyB3aGVyZSB0aGUgdXNlciBtaWdodCBza2lwIGdpdmluZyBhbnkgUGh5
J3Mgb3INCj4gPiA+IGV2ZW4gc2tpcCBkaWZmZXJlbnQgcG9ydHMgaW4gdGhlIERUIGlmIGhlIGRv
ZXNuJ3Qgd2FudCB0byB1c2UgdGhlbSwgY2FuIHdlDQo+ID4gPiBkZXNpZ24vcmVmYWN0b3IgdGhl
IGJlbG93IGxvZ2ljIGFzIGZvbGxvd3Mgd2hpbGUgbWFuZGF0aW5nIHRoZSBmYWN0IHRoYXQNCj4g
PiA+IHVzZXIgbXVzdCBnaXZlIHRoZSBTUyBQaHkncyBpZiBhbnkgc3RhcnRpbmcgZnJvbSBQb3J0
LTAuOg0KPiA+ID4gDQo+ID4gPiBudW0tc3MtcG9ydHMgPSBtYXhfcG9ydF9pbmRleCAodXNiMy1w
b3J0WCkgKyAxDQo+ID4gPiBudW0tcG9ydHMgPSBtYXggKG1heF9wb3J0X2luZGV4KHVzYjItcG9y
dFgpLCBudW0tc3MtcG9ydHMpICsgMQ0KPiA+ID4gDQo+ID4gPiBFeDogSWYgdGhlcmUgYXJlIDMg
cG9ydHMgYW5kIG9ubHkgMSBpcyBTUyBjYXBhYmxlIGFuZCB1c2VyIGRlY2lkZXMgdG8gc2tpcA0K
PiA+ID4gcG9ydC0yIEhTIFBoeS4NCj4gPiA+IA0KPiA+ID4gY2FzZS0xOiBwaHktbmFtZXMgPSAi
dXNiMi1wb3J0MCIsICJ1c2IzLXBvcnQwIiwgInVzYjItcG9ydC0xIg0KPiA+ID4gY2FzZS0yOiBw
aHktbmFtZXMgPSAidXNiMi1wb3J0MCIsICJ1c2IyLXBvcnQtMSIsICJ1c2IzLXBvcnQxIg0KPiA+
ID4gDQo+ID4gPiBJbiBib3RoIGNhc2VzLCBvbmx5IG9uZSBTUyBpcyBwcmVzZW50LCBqdXN0IHRo
ZSBvcmRlciBpcyBjaGFuZ2VkLiAoTm90IHN1cmUNCj4gPiA+IGlmIGxhc3QgZmV3IHBvcnRzIGNh
biBiZSBtYWRlIFNTIENhcGFibGUgaW5zdGVhZCBvZiB0aGUgZmlyc3QgcG9ydHMgb24gYW55DQo+
ID4gPiBIVykgPw0KPiA+ID4gDQo+ID4gPiBCdXQgYWNjb3JkaW5nIHRvIHRoZSBhYm92ZSBmb3Jt
dWxhOg0KPiA+ID4gDQo+ID4gPiBJbiBjYXNlLTEgOiAobnVtLXBvcnRzID0gMiwgbnVtLXNzLXBv
cnRzID0gMSkgLSBUaGlzIGlzIGNvcnJlY3QNCj4gPiA+IEluIGNhc2UtMjogKG51bS1wb3J0cyA9
IDIsIG51bS1zcy1wb3J0cyA9IDIpIC0gVGhpcyBpcyB3cm9uZw0KPiA+ID4gDQo+ID4gDQo+ID4g
Q2FuJ3Qgd2UganVzdCB3YWxrIHRocm91Z2ggYWxsIHRoZSBwaHkgbmFtZXMgdG8gZmlndXJlIHRo
YXQgb3V0PyBMZXQncw0KPiA+IG5vdCByZXF1aXJlIHRoZSB1c2VyIHRvIHNwZWNpZnkgUG9ydC0w
IGlzIFNTIGNhcGFibGUgaWYgdGhleSBjYW4gc2tpcA0KPiA+IGl0Lg0KPiA+IA0KPiBIaSBUaGlu
aCwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4gDQo+ICAgTWF5IGJlIEkgd2Fzbid0
IGFibGUgdG8gY29udmV5IG15IGludGVudGlvbiBwcm9wZXJseSBpbiBteSBwcmV2aW91cw0KPiB0
aHJlYWQuIFRoZSBhYm92ZSBzdWdnZXN0ZWQgbWV0aG9kIGRvZXNuJ3QgdGVsbCB0aGF0IHVzZXIg
bXVzdCBub3Qgc2tpcCBhbnkNCj4gcGh5Lg0KPiANCj4gTGV0IHVzIHRha2UgdGhlIGJlbG93IGNh
c2UgZm9yIDIgUG9ydCAoSFMrU1MpIGNhcGFibGUgY29udHJvbGxlci4NCj4gSWYgdGhlIHVzZXIg
c2tpcHMgc3MtcGh5IDIsIHRoZW46DQo+IA0KPiBwaHktbmFtZXMgPSAidXNiMi1wb3J0MCIsICJ1
c2IzLXBvcnQwIiwgInVzYjItcG9ydC0xIg0KPiANCj4gV2UgZG9uJ3QgbmVlZCB0byBjb25maWd1
cmUgR1VTQjNQSVBFQ1RMMiAoZm9yIHBvcnQtMikgcmVnaXN0ZXIgZXJlLiBJZiB3ZQ0KPiBwYXJz
ZSBwaHktbmFtZXMgYW5kIGZpbmQgaXQgb3V0LCB3ZSBzZWUgdGhlcmUgYXJlIDIgaHMtcGh5J3Mg
YW5kIDEtc3NwaHkgYW5kDQo+IG51bS1wb3J0cyA9IDIgYW5kIG51bS1zcy1wb3J0cyA9IDEuDQo+
IA0KPiBJZiB0aGUgdXNlciBza2lwcyBzcy1waHktMSwgdGhlbiBwaHktbmFtZXMgd291bGQgYmUg
c29tZXRoaW5nIGxpa2UgdGhlDQo+IGJlbG93Og0KPiANCj4gcGh5LW5hbWVzID0gInVzYjItcG9y
dDAiLCAidXNiMi1wb3J0LTEiLCAgInVzYjMtcG9ydDEiOw0KPiANCj4gV2UgbmVlZCB0byBoYW5k
bGUgdHdvIHR5cGVzIG9mIGludGVycHJldGF0aW9ucyBoZXJlIHdoaWxlIHBhcnNpbmcgdGhlDQo+
IHBoeS1uYW1lczoNCj4gDQo+IGEpIFRoZXJlIGFyZSAyIFNTIFBoeSdzIGFuZCB3ZSBqdXN0IHNr
aXBwZWQgdGhlIGZpcnN0IG9uZS4gSW4gdGhpcyBzY2VuYXJpbywNCj4gaWYgd2UgY29uc2lkZXIg
KG51bS1zcy1wb3J0cyA9IDIpIGFuZCAobnVtLXBvcnRzID0gMikgYnkgdXNpbmcgdGhlIGFib3Zl
DQo+IGZvcm11bGEgYXMgcmVmZXJlbmNlLCB3ZSBjb25maWd1cmUgYm90aCBHVVNCM1BJUEVDVEwg
cmVnaXN0ZXJzIHByZXNlbnQgaW4NCj4gdGhlIGFkZHJlc3MgbWFwIGFsdGhvdWdoIHdlIG5ldmVy
IHVzZSBTUyBQaHktMSBidXQgbm90aGluZyBtdXN0IGJyZWFrLiBBbGwNCj4gcG9ydHMgd291bGQg
c3RpbGwgd29yayBhcyB0aGUgdXNlciBpbnRlbmRzIHdpdGggdGhlIGV4Y2VwdGlvbiBvZg0KPiBH
VVNCM1BJUEVDVEwxIChmb3ItcG9ydDEpIHN0aWxsIGJlaW5nIG1vZGlmaWVkLg0KPiANCj4gYikg
VGhlIHNlY29uZCBpbnRlcnByZXRhdGlvbiBpcyBzb21ldGhpbmcgbGlrZSwgcG9ydC0xIGlzIG9u
bHkgSFMgY2FwYWJsZQ0KPiBhbmQgb25seSBQb3J0LTIgaXMgU1MgQ2FwYWJsZSwgYW5kIHNvIGlu
IHRoZSBwaHktbmFtZXMgb25seSBwb3J0LTIgaGFzIGJlZW4NCj4gcHJvdmlkZWQgYSBTUyBQaHku
IEp1c3QgYnkgcGFyc2luZyB0aHJvdWdoIHRoZSBwaHktbmFtZXMsIGl0IHdvdWxkIG5vdCBiZQ0K
PiBwb3NzaWJsZSB0byBnZXQgdGhhdCBpbmZvLiBTbyBpZiB3ZSBjb25zaWRlciBudW0tc3MtcG9y
dHMgYXMgMiBpbiB0aGlzDQo+IHNjZW5hcmlvLCB3ZSBlbmQgdXAgbWVkZGxpbmcgd2l0aCB3cm9u
ZyByZWdpc3RlcnMgKGFzIHRoZXJlIGlzIG9ubHkgMQ0KPiBHVVNCM1BJUEVDVEwgcmVnIGFuZCB3
ZSBhcmUgYXNzdWluZyB0aGVyZSBhcmUgMikuIEkgd2FudGVkIHRvIG1ha2Ugc3VyZSB0aGF0DQo+
IHRoaXMgc2NlbmFyaW8gd2FzIG5vdCBwb3NzaWJsZS4NCj4gDQo+IG51bS1zcy1wb3J0cyA9IG1h
eF9wb3J0X2luZGV4ICh1c2IzLXBvcnRYKSArIDENCj4gbnVtLXBvcnRzID0gbWF4IChtYXhfcG9y
dF9pbmRleCh1c2IyLXBvcnRYKSwgbWF4X3BvcnRfaW5kZXgodXNiMi1wb3J0WCkpICsgMQ0KPiAN
Cj4gVGFraW5nIGNhc2Ugb2YgYSBxdWFkIHBvcnQgY29udHJvbGxlciB3aXRoIGFsbCBwb3J0cyBT
UyBDYXBhYmxlLCBpZiB0aGUgdXNlcg0KPiB3YW50cyB0byBjb21wbGV0ZWx5IHNraXAgcG9ydC00
LiBUaGVuIHdpdGggYWJvdmUgZm9ybXVsYSwgd2UgZ2V0IChudW0tcG9ydHMNCj4gPSAzKSBhbmQg
KG51bS1zcy1wb3J0cyA9IDMpIGJ5IHBhcnNpbmcgdGhlIHBoeS1uYW1lcyBhbmQgd2Ugd2lsbCBj
b25maWd1cmUNCj4gZXhhY3RseSB0aG9zZSBkd2MzLXBoeSByZWdpc3RlcnMgYW5kIG5vdCB0b3Vj
aCB0aGUgcG9ydC00IHJlZ2lzdGVycyB3aGljaCBpcw0KPiBzdGlsbCBmaW5lLg0KPiANCj4gUGxl
YXNlIGxldCBtZSBrbm93IGlmIHRoZSBhYm92ZSBpZGVhIGhlbHBzIHVzIGluIHRoaXMgc2NlbmFy
aW8uDQo+IA0KDQpUaGlzIGJlY29tZXMgcmF0aGVyIG1vcmUgY29tcGxpY2F0ZWQgYmVjYXVzZSB0
aGUgdXNlciBjYW4gc2tpcCBjZXJ0YWluDQpwb3J0IGluIHRoZSBEVC4gV2UgaGF2ZSBhY2Nlc3Mg
dG8gdGhlIGhvc3QgcmVnaXN0ZXJzLiBDYW4gd2UganVzdA0KdGVtcG9yYXJpbHkgbWFwIGFuZCBh
Y2Nlc3MgSENTUEFSQU1TMSB0byBnZXQgdGhlIE1BWFBPUlRTIGFuZCBlYWNoIHBvcnQNCmNhcGFi
aWxpdHkgYmVmb3JlIGhhbmRpbmcgY29udHJvbCBvdmVyIHRvIHRoZSB4SENJIGRyaXZlci4gV2Ug
d291bGQgYmUNCmFibGUgdG8gZ2V0IHRoZSBudW1fcG9ydHMgYW5kIG51bV9zc19wb3J0cyB0aGVu
Lg0KDQpTaW1pbGFybHksIHRoZSB4aGNpIGRyaXZlciBkb2Vzbid0IGNhcmUgd2hldGhlciB0aGUg
dXNlciBza2lwcyBjZXJ0YWluDQpwb3J0IGluIHRoZSBEVCwgaXQgb25seSBjaGVja3MgYW5kIG9w
ZXJhdGVzIGJhc2VkIG9uIHRoZSBjYXBhYmlsaXR5DQpyZWdpc3RlcnMuDQoNCklmIHdlIGhhdmUg
dGhlIGV4YWN0IG51bV9wb3J0cyBhbmQgbnVtX3NzX3BvcnRzLCB3ZSBjYW4gYmUgc3VyZSB0aGUN
CnNldHRpbmcgdG8gR1VTQjNQSVBFQ1RMbiBhbmQgR1VTQjJQSFlDRkduIGFyZSB2YWxpZC4NCg0K
VGhhbmtzLA0KVGhpbmg=
