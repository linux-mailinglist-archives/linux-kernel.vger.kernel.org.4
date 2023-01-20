Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63056748B2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjATBPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjATBPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:15:42 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6BA1025;
        Thu, 19 Jan 2023 17:15:41 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JNx4Ao012900;
        Thu, 19 Jan 2023 17:15:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Y4pEcIQA/uGhDgXef/jlh0sMi1phe0+GPPYUZ9bXaSE=;
 b=PjTaVx5gNc/OAbvRkP3/Y+RW3H4PjcxSWBwxwDkRtL2MqdKqmm36lN8RYA0PqxoOrkZG
 OzqleeWshMMzyrERIxeZeri9ozKp92ACuBmdS+fVEK0EKlj3YGw5He78CcNLhxktyPE4
 gftiltpUyXsv4V0R+LlB4msXy4K6/hzQfqRhlgBogWGYFEaCNYlRQVFeRMilpQ1aE+T6
 I+h9+VIw/T9ZzXghOpBAtS1q7qZ7PjwRXU9sNAlv/5R2pYx7+a56CLLFaAzW+VS9EETW
 r09BbPSX6qykl7eOWOi9mrYVBLIgWCVFFJMJA++V5ZCozTQV6DqKEJpFoOpguoVq+cqM ug== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3v9snf4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 17:15:28 -0800
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D219F400BA;
        Fri, 20 Jan 2023 01:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674177328; bh=Y4pEcIQA/uGhDgXef/jlh0sMi1phe0+GPPYUZ9bXaSE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RaaYaKCGvVa/oBY5LDud+szhBYuSxrIsVC3lZfrXICtD0m6bq4HkrrsixkU5+EzNY
         J/W4alBRoVYjDDRy1PWCPN+EVHg9o8ZPlZX5O+3DJ4c4r6KUPIK3D22UEwaQq1hQsG
         wYx6mIz1Bi3QRbt2Xzsnw5sokIe23TOlutMweqm1Tf4cs8wQRictHY/SahUJJtAIm9
         9ybLhWPPyi00zEWnI6dnXUx1+eH4lVb+qTdwVnvfAu4twjbWouXOvYulbIyqE7TmX3
         RbfT6ZzEz8FegU/+7eHeeuuG/E/5QDNhp5M9jgk/TiTcP1ajG91569eL69AyT8VVBm
         X+zFboPj7U2AA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5CFE2A0073;
        Fri, 20 Jan 2023 01:15:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1729C400DF;
        Fri, 20 Jan 2023 01:15:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JRjkM9gL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIdwIDkWtcBWimb8uhpUSdCFZafjwBYJpEhav3W++ZRtzVxK91cmFH1gcLgjT6ObVgyHbwX17qpegWstLw96yCAhxSaGOGX288zOc9P8ERndrP0CzBnXqn8k6ypWdvO4nPXrXfIAPyq3LWZrvLm7/4J4FKqZe45rx9HKfgt95aO6F5Y8ZfiTps+7/5Z4opR5DvwLG3/nLn/czjvD2J91KOMfp/ysDB5JY1uMyfS6nKVK0ZUVKJOuwIXPbpfnPPB2ctnKvG/YfHk7SNNwooR5OF00WKSbKsC9uJ+Xnrl6uMJtsB+VMi+MtbQ0AZ3MRuwe/LCCrbYED/f/n8zbNLUtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4pEcIQA/uGhDgXef/jlh0sMi1phe0+GPPYUZ9bXaSE=;
 b=JeMD4gW7yL2ugJE+3i0oCHIkQW7zlaCyxtIYfDNO7QthDx/m4EQhcgcqrhmypLEEStJcUpW+rNfOeBZh6oTvVqFLK/bxXe/aHdKiCtntdUbxEHeyvBpZ+1ZEpTzUVGqJHg7696Vj49XVpXZtU1W4BHyDPBy/ejwuWBDPTOpw8Hxe1JBd0nTVYcZnrlVN/oWkccfT6h5nRAw6tcxW7BlKbcV4JoRIdtOeuQ1FIn+Op2X1PL2Kiz1KBup07IhTNIaxTUWeX5o2knn8dgAQbrywp4OwtpIIhTMCYO5+JK/6ztHMQ6YMkjgzz1QoDDfoAro5VCIRFZzXFrMYBZtCKjvnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pEcIQA/uGhDgXef/jlh0sMi1phe0+GPPYUZ9bXaSE=;
 b=JRjkM9gLnS+eR2b4lGXCEcnrlulfj1eTnDaXe+U6XthXbjr7sWdopgbT8cI/1P0mAQnwJzmoVkzAzDby2wxmlQksXF9mGBftcLTHrl6GTw5dy31lu5kUr1Qwl+7mjtECyY+f48yP3BFeYurIAE1x87V2FZ8ZujU5V0vkXq09nHU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 01:15:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Fri, 20 Jan 2023
 01:15:25 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigA==
Date:   Fri, 20 Jan 2023 01:15:24 +0000
Message-ID: <20230120011513.ajwum224lfwwb6ws@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
In-Reply-To: <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7892:EE_
x-ms-office365-filtering-correlation-id: 9258e83f-b1be-4f4a-09b7-08dafa83cf36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qz98xlPzVsoZnNOF/ReP4r67Bm0W+gwk6ripc0SGNUCZs+KwK6rgm1thrU7HdtdPcQ6VmRD2+R7LTbKkVpdY2IJ2porBso2JoUN3vIogsBOmRlBdC7FtOCCgEXR2TRg5BAgX0tSyYOEkRnH9Kt1bEVzk0GzfP4IFsPj7TSvRlvom994GHtCJrj/Ro4e1f2+1zjvW3iSd6TLqVGmomCZdCfPLP8Q3+tHa/1PcFaSXw3IupI+6y8lEoSVgV1D+krHup2umSqp52sJaG7ZXqAtW7fVnASgZbs2qOfVnS69G7C3K9QfPz/bf9c4TetwhT5GgO/JfJTU1uOz7ebvj3rnSJube4bSoe5eABcJwsX2TJ+uSsBwSNpVLSTlmaQH8bBZlMJtvZO+dq88U3jn7GWWGif2hdmH0KGFAQgAJViRv+KCzcNTra1k36Azkh65QZH18u3xYqTRYYhSlCPx/MktjRHD8ur/FJ5aHcsEeH89+aigkhiKlaUk0eS5NBNw1jBrCjLBuS4LG1b9vBwnglaoxBek+Iw6KDjZbK0RtloVTyI2BkRIt+8/6JyCeOYzNH935u1m9DEdEz7an/JU9unuexrsYtPMn28rkGm/3N3c2CoQ/05uMdSmrAxzfcm7lLnriBXbQ8icixRMpbWaQOLGKNsAc97zAanW69evvMsWjZRpiktHuVoOebqAmUYdL3vcdO7PCen9k0p9hmFtmh5XmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(6506007)(71200400001)(478600001)(53546011)(4326008)(66446008)(8676002)(66556008)(66476007)(1076003)(76116006)(66946007)(6916009)(6512007)(26005)(6486002)(186003)(64756008)(41300700001)(38100700002)(8936002)(122000001)(5660300002)(2906002)(54906003)(38070700005)(316002)(86362001)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZSem02d3F2UTlhVXl1VmttVVdXNzhQWC9nUVZBV0IrUXVkNE1YeStIVFZN?=
 =?utf-8?B?NHBYZ2V2ejBsSXp5VmppWFgxZFUzVGdUSlBLK1NNcG9pUzhlakJycEExeEJR?=
 =?utf-8?B?cXpwVVZ4d3lHK051V3VJSVJxT2NrMStjQldlTEg5andiWGFTOXBVaEFWeTV5?=
 =?utf-8?B?bUZkVkg0Z0loRUJRZ1hQS09ucGdpVTdDQmxlSWJtMFVkaFRyZnFqWDlnQXlP?=
 =?utf-8?B?c1pGK0lYQnNVMGRnb3k4TmJxc0hTTXpheVNJdUFQRFUvdUtHN3dKSFVMYjYz?=
 =?utf-8?B?WjdhY1FRaUwzYUduV0FFcDFxYjZ6MmI3MG51M3dhdFM2Z3dWR3VYL0JxSTgz?=
 =?utf-8?B?WFAzaHdWeFFFdjI3UlQzQ2tOeDNlZHBRV1hOS3drNE9TT2d2ZEwxMzVzUUF2?=
 =?utf-8?B?NHdBczVUaUVOSUo0TGhTdFg4dW1WQnV0elcyTU8zOURGNFBIVS92bHRBanF4?=
 =?utf-8?B?VDRYcG9MdVZPUkVmenhnNjAzUExkeWZqSHhlSjJtcjNVWTNpZlUySVdBbzRY?=
 =?utf-8?B?dnkwTXYzbmFtVy9URG1hUmVlZWE2MngvaEwrSEUwWDlPV1RZQnBxM0VGZ1Vq?=
 =?utf-8?B?UU0rYXpoOTY4Ui82ZVY2SktJODY3VzRtR3o2MXJQZUNFdVYwNWRHT2RKQmRV?=
 =?utf-8?B?TXBVTjVFanAvYzhONDdrQ2IxVUhZREpaek9Dc2laSEM5U0J1bHVseXdCTllR?=
 =?utf-8?B?eUpNTi83QkV4U21VTGF6NUwwZlRyRDV3WDFSajZkRU5YZ0VzVTVLdkJRVkZ0?=
 =?utf-8?B?SHZHU3p4eXI3RFVscDIxQmV0czQydzhMQjhFdGdhOXM3ajVNLzdEVlBHemRv?=
 =?utf-8?B?R0dXRkFnZVNEQTFWYnhTZE9KQW5MMHFlNzVJR2Z4Wk40ZTRjTG11M285RGtF?=
 =?utf-8?B?WnRFUURYT2Z3cjJYZFk3dE9RTlZRSTN5THlxQWtxUVhZV1pQNVJXanp0ZWdY?=
 =?utf-8?B?dTk5YVVISjk3bkh6dHB0MC9DZmxtckUyMldUYjFGenN2c0daeUpwS1RQY3li?=
 =?utf-8?B?aEVyMkdJTnhvTHNKempIZzd1QVZvQm9tSERwVzFCMURWZkpHcmRFUi93OG1t?=
 =?utf-8?B?cG9FOG53VExkMTdlTXlqRHEyMWNwNlpUWWxQcjRRMkdhbGh6K1A4Q3RaZUZa?=
 =?utf-8?B?d2Q2WSt4a3pYeGlJNTk0YjZQYmI0Nk9LTC93eDZGdy9XbGNFdHdrd2NyUnZs?=
 =?utf-8?B?akNUUkx2eFI3cmNRMXQzL05MY3d4dGFtZzU5dUZramFrOVJGalp5YW5aZEdv?=
 =?utf-8?B?UFlFZ1VKUm1hSEVWcU0wVzVNQkgwY0R4WGw3cWdFRnFJSnh6TUFrMDM5cWRL?=
 =?utf-8?B?WWkybUxLd2ppbENndWdFMndpWCtpMzVHRllVdzI0dGVxU0VpeGdSb3J2MHB3?=
 =?utf-8?B?bGVBWVRMMEJkZXQxVUdqTXY4cHlua0VxcjFVcGp4UGhTc1JrM1BuZTVHSDRS?=
 =?utf-8?B?ZHEvc0dDTkorMFliTGY5OUdudjBXWGdMSzdlbmtwUWIxOFZsb200Q1dEZUha?=
 =?utf-8?B?QktjVDZpSmxSUS9qNjgwQmlYcU9ncUw3SXh3dGxkMnBvcThLSUF1b0ZpR0RS?=
 =?utf-8?B?cmNDVWRKckNBZEpRMDRYRWZaY25XSG4wVW8rNzZtSFhDU1FVN0JBbnB2TFRX?=
 =?utf-8?B?ODd1UGZmNnZsZ25RTndETnVBNlJSb2NoU0hPUXIwUU1GYWR6aW5ZMTlObDh0?=
 =?utf-8?B?Y2VuVUtHWGFTWHdDSkViN3FEVEh2a3JKdWcwMTArQ0diY3NYaDNsdDFlcmx4?=
 =?utf-8?B?NGlIa0drZGhRd2N5N1kxVzBqMStaY2tOVjFKRmJYeVAzYnVzb3lrREszSWRY?=
 =?utf-8?B?TndmUXQ5ZDkreEUrTEUwYTZXMjhBRjBOVmlVYnBZUkg4K3ZCb2FDRkVGODZC?=
 =?utf-8?B?cU5YdnFTZGlCRjN4OWFBTDE0OWk5dzc3dWpnVko0QkVQOGlJa1luU0lpVXJa?=
 =?utf-8?B?TVBRa3pvYTJzQXJkbEtGdVgyRWVDRTE1ZldvTHB2OUsvRTdicFZadi9mQjhp?=
 =?utf-8?B?bmVyaVJLUGV1UVNYWmdMRTZaY0pJTFNQdXg5NGFkT1RBYW11RkxJYmQ2Y0VC?=
 =?utf-8?B?MVZiYldsMXFCMDlITXVRcURSZEpSNnIxbU1xSHNISkRBQlJxQVN3UUlDNnZE?=
 =?utf-8?B?Ni84djRIZDYyOHJHTTBsT21na3QvZW5pNjFQS3V3UDR3bW82M0Y2MUhOMVJ2?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB0E12AC96FCD45A3B115ABBDFC04F8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +FE2IFzgkywjBftDIF1SLVPzWsAYmhXAB43tZx2A3rbfpWaXoIjHYtD4hQmvxuj97VMbRYWo3l39VGacSGWIntwcG/AgeRoImpyIVcE/9eFBQjCDrBU6j5rJi1r1o76SfDeVGp4+bEXApsiBKILomntJfk7cjUaP+Qpd88ITUlHig109crQnkBBWfbgsXudpfM4sKa1Ly/954xwl7Ra/xg/Sz2zBmfpuLkbRjl0D/P9+etiMzsdKyEOhbIkbZUsWEt96Vov7VQ33kQa8FG8ggpYIAIXsn1bHM8HPLUHZVTN4+z3u7lsbGTiHZiFUxJH0PEJo0uAhcv/Dc/boBK6AWVXXjtmt4Ps47eMhxsAWsZGYQRfXFncN8LtTDEowFqk7ahFZG+fHq2bRlHapA8tJ4Qph1DIgO1Y5LmcNoURR3nxK3lK8rwPANKotxtlVHiwfm9fa8hx6xBsvILbGSJ/goGBmx/5FEuqOiqOmTfgUM/IfxZu7+ZHmGxQmsYJoIWY5bhfz77urcjzjLq3fycwkUWu8jqmxGCf1skR5/J5+PPm36bJE2MVhelC62dpF4pnGtgQvxqFmLbvSGlkowhq3M6uDoDNbbQkDo565oYuS8NoKzsxvLGeUeK4NyIYyc8F/ICIh7m/63TMZwL65naW97wCdhSLE8/Cc94jQt+OmisKBHQF55SQes1Qx7YscRgI10U0U54QE7l07BBh26l98AwTLTR59+ZjQ9CdF3qVjrlkZmaQpw8XzpomUJteKm92c5S/uQrrniANhW7bxBgcbVQfFXmHt36winP4uOX129k7bEDMsjvrJuNC/8OYo7YVW2OnDyTGnn5yzMdXbbdTxGkbvYLyRTHcdqdpMjdN0iwOjg0tHt0lwh7ucajSP6BeSKwkYfL7SPL2c8ATUDFf6H/W73MT6DZd4WyWZ81XYQbg=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9258e83f-b1be-4f4a-09b7-08dafa83cf36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 01:15:25.0118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70rYuuOhhnzBfOxx5aHZRkJM5oxbaG8sU9MeI6TmLJlKFKfeCxcmN9yKe2WU+9gwVAEfB2wfS2iEhCC7COjwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
X-Proofpoint-ORIG-GUID: lSfpQ7WBIzDTgS3REjsVhySTkhZSc-Hu
X-Proofpoint-GUID: lSfpQ7WBIzDTgS3REjsVhySTkhZSc-Hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=953
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301200007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMTksIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAx
LzE4LzIwMjMgNTo0NCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgSmFuIDE3
LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gQWRkIGEgZmxhZyB0byBpbmRp
Y2F0ZSB3aGV0aGVyIHRoZSBnYWRnZXQgaXMgY2FwYWJsZQ0KPiA+ID4gb2Ygc2VuZGluZyByZW1v
dGUgd2FrZXVwIHRvIHRoZSBob3N0Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFbHNv
biBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jIHwgMyArKysNCj4gPiA+ICAgaW5jbHVk
ZS9saW51eC91c2IvZ2FkZ2V0LmggICAgIHwgMiArKw0KPiA+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ID4g
PiBpbmRleCA0MDM1NjNjLi5iODM5NjNhIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9z
aXRlLmMNCj4gPiA+IEBAIC05NjUsNiArOTY1LDkgQEAgc3RhdGljIGludCBzZXRfY29uZmlnKHN0
cnVjdCB1c2JfY29tcG9zaXRlX2RldiAqY2RldiwNCj4gPiA+ICAgCWVsc2UNCj4gPiA+ICAgCQl1
c2JfZ2FkZ2V0X2NsZWFyX3NlbGZwb3dlcmVkKGdhZGdldCk7DQo+ID4gPiArCWlmIChVU0JfQ09O
RklHX0FUVF9XQUtFVVAgJiBjLT5ibUF0dHJpYnV0ZXMpDQo+ID4gPiArCQlnYWRnZXQtPnJ3X2Nh
cGFibGUgPSAxOw0KPiA+IA0KPiA+IFNvbWUgZGV2aWNlIG1heSBub3Qgc3VwcG9ydCByZW1vdGUg
d2FrZXVwLiBnYWRnZXQtPnJ3X2NhcGFibGUgc2hvdWxkIGJlDQo+ID4gc2V0IGFuZCByZXBvcnRl
ZCBieSB0aGUgVURDLiBNYXkgbmVlZCBhIGdhZGdldCBvcHMgdG8gZW5hYmxlIHJlbW90ZQ0KPiA+
IHdha2V1cCBoZXJlLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBUaGluaA0KPiA+IA0KPiBOb3Qg
ZXhhY3RseSBjbGVhciBvbiB3aGljaCBwYXJhbWV0ZXIgaW4gVURDIGRlY2lkZXMgd2hldGhlciBh
IGRldmljZQ0KPiBzdXBwb3J0cyByZW1vdGUgd2FrZXVwLiBIZXJlIEkgaGF2ZSB0aGlzIGZsYWcg
anVzdCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRoZQ0KPiBjb25uZWN0ZWQgZGV2aWNlIGlzIHJ3IGNh
cGFibGUgYmFzZWQgb24gdGhlIGJtQXR0cmlidXRlcyBwb3B1bGF0ZWQgaW4gdGhlDQo+IGNvbmZp
ZyBkZXNjcmlwdG9yLiBJZiB0aGUgVURDIGRvZXNudCBoYXZlIGEgY2FsbGJhY2sgZm9yIHJlbW90
ZSB3YWtldXAgd2UNCj4gaGF2ZSB0aGF0IGNoZWNrIHdoZW4gY2FsbGluZyB0aGUgZ2FkZ2V0IG9w
IGluIHVkYy9jb3JlLmMgKGhhdmUgYWRkZWQgYQ0KPiBzaW1pbGFyIGNoZWNrIGluIHVzYl9mdW5j
X3dha2V1cCgpIGFsc28gKS4NCg0KVGhhdCBmbGFnIGRlc2NyaWJlcyB0aGUgZ2FkZ2V0J3MgY2Fw
YWJpbGl0eSwgbm90IHRoZSBkZXZpY2UNCmNvbmZpZ3VyYXRpb24uIEhvd2V2ZXIsIGl0J3MgYmVp
bmcgdXNlZCBhcyBhIGNvbmZpZ3VyYXRpb24gZmxhZy4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPiAN
Cj4gaW50IHVzYl9nYWRnZXRfd2FrZXVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpDQo+IHsN
Cj4gCWludCByZXQgPSAwOw0KPiANCj4gCWlmICghZ2FkZ2V0LT5vcHMtPndha2V1cCkgew0KPiAJ
CXJldCA9IC1FT1BOT1RTVVBQOw0KPiAJCWdvdG8gb3V0Ow0KPiANCj4gVGhhbmtzDQo+IEVsc29u
DQo+IA0KPiA+ID4gKw0KPiA+ID4gICAJdXNiX2dhZGdldF92YnVzX2RyYXcoZ2FkZ2V0LCBwb3dl
cik7DQo+ID4gPiAgIAlpZiAocmVzdWx0ID49IDAgJiYgY2Rldi0+ZGVsYXllZF9zdGF0dXMpDQo+
ID4gPiAgIAkJcmVzdWx0ID0gVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRVUzsNCj4gPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3VzYi9nYWRnZXQuaCBiL2luY2x1ZGUvbGludXgvdXNiL2dh
ZGdldC5oDQo+ID4gPiBpbmRleCBkYzMwOTJjLi4xNTc4NWY4IDEwMDY0NA0KPiA+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC91c2IvZ2FkZ2V0LmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdXNi
L2dhZGdldC5oDQo+ID4gPiBAQCAtMzg1LDYgKzM4NSw3IEBAIHN0cnVjdCB1c2JfZ2FkZ2V0X29w
cyB7DQo+ID4gPiAgICAqCWluZGljYXRlcyB0aGF0IGl0IHN1cHBvcnRzIExQTSBhcyBwZXIgdGhl
IExQTSBFQ04gJiBlcnJhdGEuDQo+ID4gPiAgICAqIEBpcnE6IHRoZSBpbnRlcnJ1cHQgbnVtYmVy
IGZvciBkZXZpY2UgY29udHJvbGxlci4NCj4gPiA+ICAgICogQGlkX251bWJlcjogYSB1bmlxdWUg
SUQgbnVtYmVyIGZvciBlbnN1cmluZyB0aGF0IGdhZGdldCBuYW1lcyBhcmUgZGlzdGluY3QNCj4g
PiA+ICsgKiBAcndfY2FwYWJsZTogVHJ1ZSBpZiB0aGUgZ2FkZ2V0IGlzIGNhcGFibGUgb2Ygc2Vu
ZGluZyByZW1vdGUgd2FrZXVwLg0KPiA+ID4gICAgKg==
