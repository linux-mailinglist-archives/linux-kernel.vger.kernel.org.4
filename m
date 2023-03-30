Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C442C6D0220
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjC3Ku3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC3KuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:50:16 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2105.outbound.protection.outlook.com [40.107.23.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738128A61
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=PqXJoXrtdB2wEeBP2EBYdRvE/V7MPgQLQnkRKW2jE0azXsCADrKg8wlMOWbRS/jd5cG5TXuUAJhfgtAkmv/iwFSD2qdwWYEsZvRZXb87p8cNqVzfl3Ia5BYWodhXrsuqVlsu5PEtYneVubCBZT3okzK6cux11bx9R7zlmKUoeLo=
Received: from FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:92::19)
 by GV0P278MB0161.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 10:50:13 +0000
Received: from VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:92:cafe::55) by FR2P281CA0048.outlook.office365.com
 (2603:10a6:d10:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 VE1EUR01FT045.mail.protection.outlook.com (10.152.3.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 10:50:12 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 30 Mar 2023 10:50:11 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=QI4qt+l7+5b15zLLPi7mHbOpvQDneLfcn/7FEYvy+Z12aWGhFqe1pCcZCsM5Jb9ubdVXh9rY1ZAwFQZzXaSOJQKFB2zCrviuRpmR2LjN1O/VJMSDMEL/mdc4pzyU4SZCwmGF2FFVAaWkNzhLoq5CGWxHKQAtzutlsdPjXY3PcF7tB5A/RUFSD7JZuOpBcGTu/UVEsZqN3IreG2ZCCU2suNkCAVVRJXmZQSY0Mz78tvq2eWWr5uKcp/gdyl8AVz3ExrOa4dGzTiOJv7gRAOxqF4tIViiotkb+WxTLpzqbtezGrocEuhZJCe+Tp92BIEylmpl5uGjm7Ij4ozL2hBcesg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=XDQSY4LkdA84xTFJT0I/AWjMOCgtFUK/Q6o7gWeFzNpfQd2SKyiQjDYsiCgoF2BLbkr8BkpqMSKoF312jn9eRB+R3XIj0wQUFEBlYsb8aBjG7AoYSkh/WnPAlD2vPf5AYLRmU5ZrNhIZ2pa9MWH5PCgEVbiOEybhBXUcvFwr0RlsHzjYs6gw3dJUrWKv061YnuI+tWq7/FNXySDB9ttQwILuMo2SKeFe8zyMSSAufPEfn47K7B/UxA4xpYx8GKqhZXWHfXhi2bOOVgA6xsPh7oUL17OEt2kdvqb9M+JUq/dE49d4zOMBT64WY6M/So+LRVa8J8yC8c/OjdETL8GENg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=PqXJoXrtdB2wEeBP2EBYdRvE/V7MPgQLQnkRKW2jE0azXsCADrKg8wlMOWbRS/jd5cG5TXuUAJhfgtAkmv/iwFSD2qdwWYEsZvRZXb87p8cNqVzfl3Ia5BYWodhXrsuqVlsu5PEtYneVubCBZT3okzK6cux11bx9R7zlmKUoeLo=
Received: from GVYP280CA0020.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:fa::16)
 by ZR0P278MB0122.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 10:50:10 +0000
Received: from HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:fa:cafe::35) by GVYP280CA0020.outlook.office365.com
 (2603:10a6:150:fa::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 10:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.43)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.43; helo=CHE01-GV0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 HE1EUR01FT097.mail.protection.outlook.com (10.152.1.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 10:50:09 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Thu, 30 Mar 2023 12:50:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhY0OBc/t1VYCGNEO0BQ7+4UppSKqWp5yFiuUKnTc04e1piYjpa+R3CHDgnZXGPLSkQMUspxBxXJAjjcw1ZQSlckXglpPvdPj/nTifHoYZEA+xbd8VyIEX8DUmmAX3xCSEhL+apKxkMU4gWTC9WqaFdTkvyzFivPFtcvGIhwBMqJHkHjrzejJ0qNhc8vr9W5qfCcjESp/xUeP+hDbZOHCeI4mdIFm3g9POnpaThazA4dzirO/5fVSdUrCQ/i5nUvs8mxpF5iBd5HOfvqhR9oO+KQMAembueV6v4ik8JO7+isoizpUhQ6xLJPA9E/6coYlkFVjYk6Uhk1PHLa1wBhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=CQlJu3Q5oRzljDx6rZriYfWgoGJoB3yv7ZvMYTi2GrB2O5dXBSn0ssxjWblvHg2/nRqGWeyodwDeUIz15NXEUdqs67XG3900cMxZOgFEFosvGHMYZmdZ8S5+4z+7TFq0tv8g/ST6mfPeDMeCANJ1FnFlkJ+yGfN1kd8Xfz5V0in/yXWslqveCC2r3w6XSR38D85R+fxrPn+rbjKWCnMGZKpWTXXT4iB0kDeMebbVEEZ9QgJuoIi8LKYf5eFqAKcF8Ce3B2aSzqzig8YreF8Y8tlB6xTnEAw9JLpf2GJjEo9/UG5FiktP5zY4W8r1W60caGPQ+2hSXKEoG4u0Bcp13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=PqXJoXrtdB2wEeBP2EBYdRvE/V7MPgQLQnkRKW2jE0azXsCADrKg8wlMOWbRS/jd5cG5TXuUAJhfgtAkmv/iwFSD2qdwWYEsZvRZXb87p8cNqVzfl3Ia5BYWodhXrsuqVlsu5PEtYneVubCBZT3okzK6cux11bx9R7zlmKUoeLo=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0741.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 10:50:07 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%8]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 10:50:06 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 2/3] mcb-pci: Reallocate memory region to avoid memory
 overlapping
Thread-Topic: [PATCH v3 2/3] mcb-pci: Reallocate memory region to avoid memory
 overlapping
Thread-Index: AQHZYvVkH/iO56PxR0ejBYQErX9x2Q==
Date:   Thu, 30 Mar 2023 10:50:06 +0000
Message-ID: <20230330104949.21918-3-josejavier.rodriguez@duagon.com>
References: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0741:EE_|HE1EUR01FT097:EE_|ZR0P278MB0122:EE_|VE1EUR01FT045:EE_|GV0P278MB0161:EE_
X-MS-Office365-Filtering-Correlation-Id: cd882885-0997-4dbb-f92e-08db310c8a0e
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AD/SO1Zle8KxLhz+kvO1RhttJZ+47bGnUhSm38/QPOGdwuZG/1bwdJwyBiUfz4m3YyqjDm6GS7Gj4l6Q6TWgHR9pw4jQtMXuK8waJUexxWPN188qORBZDCDMbkDL0FCrTcXZsCb3QPsbI37/AzIJ6piP3GD7ceB3SCE+5Ja58rrl1n97nmmI+crAA5Jt7vHG3GfHNdiTr71cyyqt/zf1SdvULTd+hBnL6zXu9vlqD1et+EA8yqKOYr+RNonkasITWeJfK7s+s77gAmYoMa5R4sSvWK0GNOZNnGbiZEHIp0ZGruDxYbXgq36dZzLxv6XAjvg9jv/8Y82Gd1kPi7TXu7OvmGNYABXdCFMNp71vjUjGaurkJ3rafw3HLN3VReUlHqo6bcxA6OHHwmxOLMLFi3FEj1aGtH8aBrqGeTviE9v7UvAjCq4kYC0hJ7h9mNnE2cKYPQZQRj4/dXYgY9ruKtnVgNInLQJ+cuM+rgwKhk60Pk6bG6EvQY5EAukRuudAdddhB/UTG0VnHYE1FT+W35Tr+VCyY0p5z0IlRvq040THTQ4kYbzOqAB2FERju0H3WXCifZUfEw0qC9F6z2maq3aORV4kvsMoVmCZYJ0bhyJVUU34R7Drm+2sfjVwoys3
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39850400004)(346002)(451199021)(83380400001)(2906002)(5660300002)(8936002)(36756003)(38070700005)(38100700002)(86362001)(122000001)(6512007)(6506007)(316002)(64756008)(66446008)(54906003)(4326008)(66556008)(6486002)(8676002)(66946007)(76116006)(66476007)(26005)(91956017)(186003)(1076003)(71200400001)(107886003)(478600001)(41300700001)(2616005)(110136005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0741
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.43];domain=CHE01-GV0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f9d430bb-e1c7-4cbf-580a-08db310c8684
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cs6I/oNa8nixVGDZsbumsMlf4aUusqNz7909qO2/WRpgKC29OEuuWrp3cwZ748P/jMdVK7kcOnmib57MsiyyUFATSkj5YshAkS5r8V/BKhxZxJsWQuCQz1hXFZV85/3mv/edJl6Gxu+XYXlRIOK2jd5IEhBh1q7MiBo2wLoDbpLKfQx5XLumm4ThiHeXyZvuRvlAwufn3vBgxCKAxRa7pVnAAghXFNc2YhPHYHb1JkrE640o+7PqgJq/KLT0iGk1hBnAIIJl89hJOnt3p55RkEj3SoDe4jr4BQ9GccAZoaygZ0PYC8BUiCIuhOnDYKhf42yIHRde10Zeiw8i9OSc+PrKQuNX7sflMVJyBzrbTy+wWmuJvpxVzu1bpzgkZHE0S99Ma+nP6en/whrTwelPNgZiuHHMwDe1q4ub0q8OPbCYYiVH1QeHkFsV4wMnZxlQkxhS8+6voEnwSFf6k7mtEjuUVSWFoO2QTfLM+yMBxVgRIrokWWw3TEqUH8zKEICk+jbGHQ43wVPyYqUUw4C0Pp4aQuYaBWBt/LpC4mf+7XG4MP3EGMAUcPTulmmigl+3Xgi5qPM9t/XiwX/sWEO0Fmo0fi0oP+5qBj3/JzC8RHV7XhkEuE2eqg8ouHJfFSejqLHoxYKl9rh6hyy3YXYElOGjUZVMQGJx152/bXRFgYD0LQWFSavZWs/cfMsAiRCta994Xj8gwwkojwCclmAVkoMfQO8nUFfgmgxsurGRA9oaQ5XwYwvdvvWdnLyMTmIhhtOIn89Ti+qF7mw5af6EKtYcegEkb9HorLALaiJ25E7RNHfc/u/8wU7+X78rbSxg
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-GV0-obe.outbound.protection.outlook.com;PTR:mail-gv0che01lp2043.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(376002)(396003)(451199021)(36840700001)(46966006)(478600001)(2616005)(6486002)(36756003)(83380400001)(47076005)(336012)(86362001)(40480700001)(156005)(36860700001)(32850700003)(7636003)(82740400003)(26005)(186003)(1076003)(6506007)(107886003)(41300700001)(2906002)(82310400005)(5660300002)(110136005)(54906003)(8936002)(316002)(4326008)(8676002)(70586007)(70206006)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0122
X-CodeTwo-MessageID: 5c753910-5bd1-4807-acbe-521f7bda90de.20230330105011@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 094d5eed-b024-4a6a-c23d-08db310c886f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+pXJhzklMbDj9ZGeZRa7Rdhe0/OdLftFnLxHjK9WOqjQuTabu0yIewUJjEp3US/4CJuBXvrSnsch30iJVoSfsUXdZnKDzJjjx9Gj/+uqQXL/dAKpG33h0Kvf+tKaFLWdMn/WK9a8icp3t4GElBcZQXrzsECf6oNkLWvz0JvK6MRTt3syyx4dtuZdkjHDNF4vi8a1OImC6yO2S5lRPeUF17hszjNIBFoNETMbNpUvpm1E2QCNBqoY+0whsKLJ3B6JtZTXiTHULEz8bmwsyLghjDFOw8IrBHJhKWuSOx5Oigf/n9iMNq5XTooE4oAv3dWGDp59XBuvtxLmwAD2uZQvnKRDSuToA+JPPhOQURLMC6ohn3kVMV0mAfpouXilhsyAfChao/gWOEu83luwRXSu83ka0Rcv1lsmJ5WcqrlszY6C67a6YXlhHutzztlNxWQI7C3P+BNFGgZ7aoWDmxHxh7t/kPjd/lso5qWhcdqLUMonNWNHqq1rQzNAnRS3AYQWAXQ1Gutmr7iOULjqEHR04KT3a0h23uR8M+QhGLXhoQ38jPCGwtdEAJMQhRlIqzVeStVAqb7Ip4NtS0QhPSHSGcweu/e5UFt+iPhQKjBdtVF1492KzcHf7WnZ9C5rIUwaShcO+Kj1pDblQvWFegOEMX+BdII0B75wtZo8De8uKA=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39850400004)(451199021)(36840700001)(46966006)(336012)(47076005)(2616005)(82310400005)(83380400001)(36860700001)(6486002)(478600001)(316002)(54906003)(110136005)(186003)(26005)(107886003)(6506007)(6512007)(2906002)(1076003)(5660300002)(4326008)(36756003)(7636003)(7596003)(8936002)(8676002)(70206006)(70586007)(82740400003)(41300700001)(40480700001)(86362001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 10:50:12.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd882885-0997-4dbb-f92e-08db310c8a0e
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0161
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-pci requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-pci.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index dc88232d9af8..53d9202ff9a7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -31,7 +31,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -90,7 +90,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	if (ret < 0)
 		goto out_mcb_bus;
=20
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size =3D ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res =3D devm_request_mem_region(&pdev->dev, priv->mapbase,
+						table_size,
+						KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret =3D -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base =3D devm_ioremap(&pdev->dev, priv->mapbase, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret =3D -ENOMEM;
+			goto out_mcb_bus;
+		}
+	}
=20
 	mcb_bus_add_devices(priv->bus);
=20
--=20
2.34.1
