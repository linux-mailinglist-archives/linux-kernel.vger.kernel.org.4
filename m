Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8889D6DF952
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjDLPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDLPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:05:52 -0400
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ABEE6A;
        Wed, 12 Apr 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=587; q=dns/txt; s=iport;
  t=1681311951; x=1682521551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZsIcQTqI2jlj+q+1ASNCr/fgTMeYjUkWyBXRB6TaLk0=;
  b=XRS74edicBMBwGth8SqiI9duOIgNi8LM4JoVapBRI5CqNigv68iEGVW/
   rZPr9Gn93smgdqGNIRwL0I8SCoLRiUDs2id+aMxKeZNcn5y1KaNmTuOv3
   uu4EyYeo22VC4SSOOjoGZeOI3FJSJ0pta8PZdSMts9wR4ONJ8PH3ZNinB
   Y=;
X-IPAS-Result: =?us-ascii?q?A0DAAADmxzZkmIwNJK1aHQEBAQEJARIBBQUBQCWBGQUBC?=
 =?us-ascii?q?wGBW1JzAlkpEkaIHgOFLogzkiCMYQNWDwEBAQ0BATETBAEBhQYChTwCJTcGD?=
 =?us-ascii?q?gECAgIBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFa?=
 =?us-ascii?q?A2GBAEBAQMSKAYBATcBDwIBCBgeEDIlAgQOBSKCXAGCXAMBn30BgT8CiiB4g?=
 =?us-ascii?q?TSBAYIIAQEGBAWfIQkWgSsBkTknG4FJRIRAPoJiAoFghiAimkUKgTR2gSAOg?=
 =?us-ascii?q?TyBBAIJAhFrgRAIaoF5QAINZAsOb4FJgyoEAhRHNwNEHUADC3A/NRQgBliBG?=
 =?us-ascii?q?SQFAwsVKkcECDgGGzQRAggPEg8GJkQOQjczEwZcASkLDhEDUIFHBC+BXQYBJ?=
 =?us-ascii?q?iSeCIFVgwnEAgqDfotylHtNE4NXgWijcJdzp3YCBAIEBQIOAQEGgXkkgVtwF?=
 =?us-ascii?q?YMiCUkZD44gGYNZhUKKN3U9AgcLAQEDCYtFAQE?=
IronPort-PHdr: A9a23:A0KnWxFak6xOGfzqHDwyU51Gfu4Y04WdBeZdwpMjj7QLdbys4NG/e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgFofUjsmzyOma8JzIaAIOjz24Mvt+K
 RysplDJv9INyct6f78swwHApGdJfekeyWJzcFSUmRu9rsvl9594+CMWsPUkn/M=
IronPort-Data: A9a23:WFuFwKgFPpR/2hwezZr9JLyoX161QxAKZh0ujC45NGQN5FlHY01je
 htvCGrTO6mONmX1eot/bI7i9kIAvJOGzYBhQQFv/39kFyhjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+lH1dOKJQUBUjclkfJKkYAL/En03FF8MpBsJ00o5wLZl29Qw27BVPivU0
 T/Mi5yHULOa82Yc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMq
 0kv+5nilo/R109F5tpICd8XeGVSKlLZFVDmZna7x8FOjzAazhHe3JrXO9JEWF1KpzCgmul38
 8RUnJKoFyd5Oa/TzbF1vxlwS0mSPIVP/LvBZHO4q8HWkAvNcmDnxLNlC0Re0Y8wo7ksRzoQs
 6VDbmlRNnhvhMruqF6/YuVlgMUuKNbiFIgeoXpnizreCJ7KRLiSH/qVu44JjV/cgOgTMeTPf
 NM4MwZKQxLhODpXM10MVI0hybLAan7XKm0E9w39SbAMy2zSyhFhlbvgKtzYfvSUSshP2EWVv
 GTL+yL+GB5yHNCS1zuO/262i+Lngyz2QsQRGae++/osh0ecrlH/EzUfUV+95PK+kEP7BJRUK
 lcf/Wwlqq1aGFGXosfVByyivVKBlxslXeFBCsQ08F+tmq3W/FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXIFhpxEZ/J9VuP1TgpwXwqPnVUEFdZizX3iMRi0E+eH44L/Lud1IWdJN3m/
 9ydQMHSbZ08hNQP3qO3lbwsq23x/sSSJuLZC/m+Y45Ixgp9YIjgbIuy5B2Eq/1BN42eCFKGu
 RDoevRyDshQVflhdwTUH43h+Y1FAd7eb1UwZnY0Q/EcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzM/8uOdnuW593lva4fTgAahwyRoQWCnSWXFLYlByCmWbLt4wQuBF2yPpma
 cvznTiEXCpDYUiY8NZGb75NjeB0rszP7WjSXpv8hw+2yqaTYWX9dFv2GAXmUwzN14vd+F+92
 48Gb6OikkwDOMWgOXO/2dBIcjg3wY0TWMqeRzp/LLDTe2KL2QgJVpfs/F/WU9E8z/QPzryWo
 hlQmCZwkTLCuJEOEi3TAlhLY7L0VpE5pnU+VRHA937xs5T/Se5DNJsiSqY=
IronPort-HdrOrdr: A9a23:qE3y762jRrD2pqM2uNpCegqjBetxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7Lk819fZOkPAs1S/LZnimhILaFvAT0WKE+UyhJ8SezJ8S6U
 4ESdkdNDSeNykGsS+X2njeLz9k+qj4zEnKv5ac854Od3AXV0gI1W4QYWz3fjwSNW177NgCZe
 WhD6F81kKdkAEsH76G7w4+LpP+TrPw5fTbiDc9dmwaAQ+14w+A2frfKVy1zx0eWzRAzfMJ6m
 7eiTH04a2lrrWS1gLc/3W71eUSpPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcRls
 XWqRtIBbU215qRRBDznfLe4Xi47N8c0Q679bZeuwq5nSXNfkN9NyOGv/MCTvKW0Tt8gDg26t
 M544vQjesjMfqHplW+2zANPCsayXZdZhEZ4LIupm0aXo0EZLBLq4sDuEtTDZcbBSr/rJsqCe
 90EajnlbtrmH6hHjvkV1NUsZaRd2V2Gg3DTlkJu8ST3TQTlHdlz1EAzMhamnsb7poyR5RN+u
 yBa81T5f5zZ95Tabg4CPYKQMOxBGCISRXQMHiKKVCiEK0cIXrCp5P+/b1w7uC3f54Dyoc0hf
 36IR9lnH93f1irBdyF3ZVN/ByISGKhXS71wsUb/JR9sq2UfsuiDcRCciFmryKNmYRoPiSAYY
 fGBHt/OY6VEVfT
X-Talos-CUID: 9a23:sjcipWHqJZOLdze5qmI/xVQJNsUMd0Tb92bJCkGgV0Y5T7+KHAo=
X-Talos-MUID: 9a23:RJ8KDQpuZ4rkrU0fGJEez2xOJtZz+oX0NGUil7RdnNGNPzcsJCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 12 Apr 2023 15:05:50 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 33CF5kPB013124
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 15:05:48 GMT
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:05:46 +0000
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:05:46 +0000
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:05:46 +0000
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="5.98,339,1673913600"; 
   d="scan'";a="69468"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKibRvTj02edMznyBHJrpvez2zFSCRO2vABud2B9NSpZOZwCHBSxr7EGC/DDYd9wo+Mz7MWn8glXbdjkdqVix2X0vfzkmBjCs8FwMFVuOHc9DXK8DyaqFd0YO9irgYarezlNFolhvfOiR9u52gb7aAWxUJfcHB1+JvvsDRLUJ7gjZyNIprS3Djk8zExyF0t9WaZFzRHzkdhCGS2SHLcw0I575mmib0+tTLtyS4wYTMfasiQceiipIJ/TBGiFGoU081O1yzcics8mlFcRmWXcX2Zx+puZAMR6UkUJt7kE6r31zHs+WUbpRb6J+fQDjV4s5j1VZs6iBGJDjbBxxxLQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsIcQTqI2jlj+q+1ASNCr/fgTMeYjUkWyBXRB6TaLk0=;
 b=KWyRtHv1DsuD1RCRCE9ImFDIIA6vJK4bqxItPm51y9Wo++NeM3eH3WqedCtREa0wAf1dl4iSINj9XXIWXRF5HHFhAhlHu9/zrXjyWfbDmZA4EUVvOl+LKtbTOlPnpSrc4WB2ZJykc4Zq1rkKNeLZ2R7UiQTa7pMhyEd47QlIm7tH1vhJ1LAubzbbug2DgnvPPBtQrsPntNaIWVyd5rnEGjNmLKt51duw680ugQhBi3GzcAH9hU399oWwHxTe/vlqOsobu5Xd3YsKV22u9Pn+xeNa9JkBxUhb3pztT3z07b3lle3sG5LC4X3LSBD+9tR+51/RClQ4Hge2gT2LiraeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsIcQTqI2jlj+q+1ASNCr/fgTMeYjUkWyBXRB6TaLk0=;
 b=c5jauJ/4KUnYbu4sr1ifhYC8hnwQdoBLlp0xPc/iGKGUjbVu9BncbQvbOUBZXdpe0hDElk6PAjrFRZqLZ2L/k/zUe9ZO7zk8RS7I+UupvDGNbXUeEd0rgD62kwCXa7RxtqLuoao8z4SxjKGZ8us1MfDkhKimcP2WYTqprBIuFrQ=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by BL1PR11MB5415.namprd11.prod.outlook.com (2603:10b6:208:315::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 15:05:42 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::66a3:de62:35f4:ad97%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 15:05:42 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Topic: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Thread-Index: AQHZbVA/W/PiGCKJbkGjA/VaWrFw5w==
Date:   Wed, 12 Apr 2023 15:05:42 +0000
Message-ID: <20230412150541.GR1391488@zorba>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <20230412135050.GA2219534-robh@kernel.org>
In-Reply-To: <20230412135050.GA2219534-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|BL1PR11MB5415:EE_
x-ms-office365-filtering-correlation-id: 056d72a1-abb8-4fb3-18fe-08db3b676272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loqTqaz2m0x1HmUupjVxl5BGfKPcB1l/gtJz7ulEJ2MWXQ5tTQM4eXQEkdwUIr4ayDUvxKNC04/g+z0n6GGw+buR+dIGux81/PGvQWBdIyeUa2NuHdVefY8KKfq0eiF9YzK2vYVRhtBCfAU+4kzl3uf6OABm9KsgLG3Ig/5PExOjwvY7a4Hv5FtFE7APW6Y40iX4r4vTdBRTAcu4y2YSjksOWAnup3JFH2Jxe4BsjHRLmUgvoWIfJOZKPGAcKT/a6USr32JC3IuhiaItNbDZG6KrzprDPp3F6kOMGLJGLPhYl6OueSuFf1vxZOp+Y/UqHMZRR+Iujj79FvoxtQOli6mDuhwmJocAIA2VNv2WFRaE674hNW1vGanBlRK+6mBILbeIAjuwrNmjXAKBt0qxM+DeZBOPTJLJjgr2YLqcGZ+SlI4H9fsVWx4DfPqbTTj/RmZi+C67ia2JzMytOzsjOHLu/vWuUePnGxxsG4iIRpT1c2euSuGUGqDpJjeYAFzJCoSosK+7ycQoG5fe3pksXlSRclkMSHyUHO4+m7F9J+b0IBQrsSPM3lLp4z+KH/CD7KaKBh0e0ny2owgOFE2QKFIGl/20u29EDvAsFNaJhxbWHFnLVTxdNi8B1MokHVvB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(2906002)(4744005)(8676002)(76116006)(33656002)(478600001)(8936002)(5660300002)(41300700001)(316002)(66946007)(64756008)(66556008)(66446008)(66476007)(54906003)(6916009)(4326008)(38070700005)(86362001)(71200400001)(186003)(38100700002)(6486002)(1076003)(122000001)(6506007)(9686003)(26005)(6512007)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S1w+x13IQzpG0nBWiCDwPF0oJ3aR9wl4EUJhc0WRqqVPdNNt2ECayUAXQkz7?=
 =?us-ascii?Q?t5PEu/Le9x+uP5ome97atXEcR2zkP3Dnl3NB5kVC7ES4uWKPX1fgdkVK55Tg?=
 =?us-ascii?Q?jWiUuK5DeMfYqeXnZTV+jYy/s9Od91pn+qjiV7kz2yK6620t71S/G/RrAv9C?=
 =?us-ascii?Q?YdwfaqEAfv2Rxbk4p+N9iMngCSAu6r9FQMNtC/NUBEhC1gYOMHyilkhVr7m+?=
 =?us-ascii?Q?6f0vTgQq4plA1jjjem0OHlUqP8QEN+I1j5Iiv3AMtdGLm4QXSjJmlfrPrunn?=
 =?us-ascii?Q?0vJjlKtK5bN7qi247jfzjwUT3wsfl46K5VVCBw7vuda1/zEa3QdHfLXmjU8f?=
 =?us-ascii?Q?ojtpl3b0+h14L9np42znw8J0v0Rn2myhfEbaXDcBeGBCWJtLW4YYJchbEHqc?=
 =?us-ascii?Q?FYBKT2nrA0QsazZrvL8ErgxwZEg3ar7p00B1Es5HCmLj+2o65v37ec5opWrs?=
 =?us-ascii?Q?POcHDiFCMegLb58AY1kf322AQMdLUsqu3RJ5hcdzdR77A6Fr7HGYsFb0khXO?=
 =?us-ascii?Q?YR3u7jDjAYjnaAw7xcKsMyLqCgCpY8hfUa6qXLGudhlyoyZGdRDwpEvF6XCl?=
 =?us-ascii?Q?Wp4iX6+uZV37IgK1fhFEUaKne2kR9dDO2HZDee0E6fA7e5KGjF9i97cLVaOK?=
 =?us-ascii?Q?2tILw0xU3Dr7jKUbSQjGEBuuXe4rS2CqaLMIIbDYzFoO2z1Urtc/YZzWCx2X?=
 =?us-ascii?Q?+uN6Hx9qu+QA/O3LJqmTMYMVA1nUf7un4qYJkYU0xYS5SEDpdCp3yrmZkPoH?=
 =?us-ascii?Q?prXcFsstgK3KELmNPE4TXnW2mk1ceVKF3qRLKI/Rfkmn+LWjsVAsZ51hezJ8?=
 =?us-ascii?Q?dlJ2prd80+RyLzwdnLSlO7KDFEqBU7GukAV5fi+TL8glelNDo9v2MOyYAo7U?=
 =?us-ascii?Q?6Uykj1fzzKOEWGBQKPcR4rw0JG8s8mkRvKti+G6VVH5BiuK57Moatt/DB8Az?=
 =?us-ascii?Q?DL8r6mrpiV7nV7oVX6EIuQVf6ycOrEQS5NtQ2amq+gH2gJugj5+YIPq0vKun?=
 =?us-ascii?Q?qrIz1j4L4Jl7B1y7/te609jDFA8tOKI1ypQzo6zqv5gJuYDv0VaQeQPjjZen?=
 =?us-ascii?Q?D/ILagGoVrWyATwhPIsCWIxPt354JyFGTIe2ZtrK4UgfUulutKNC7VnyvfXe?=
 =?us-ascii?Q?r5enDza5LeIxwhea2ozNl8QZPsDx/7uD3b/+eRDKS5Y7LNgmb3hwAztgdRNr?=
 =?us-ascii?Q?mtZmT3cYanKwRJpTzOrvMw6JLtkC56JJ0iAl3DME+F4jBCB8sm6H0jJnnL5T?=
 =?us-ascii?Q?yRFxwXX9yv9r4Oe5ZpVjC42Vby8ublQNMoK2PrAb5v6UwY65EIUj4IF2VTg5?=
 =?us-ascii?Q?cKKcgzOJn0WJ0Ye5jLBxK5fOax0e7c+Q6fJqf6PjQXatA27WXDqaFn/81YY5?=
 =?us-ascii?Q?rHzTPIGA3KwvBPNkINyYNY95rh5Bx4r1ZUoZauAqxHty0VnBbxfvmDnq51MJ?=
 =?us-ascii?Q?iFzBWxIYz46umSJOuTJm4Pr3Z5XAGA1f92cmxTTgC07U5CCsbTfnHhapxGzQ?=
 =?us-ascii?Q?YZNfh/XgSatU6lgkmGH1P/wr4cn+VIcTRs2NAXgphMWUZUH7mLlXY770sMtc?=
 =?us-ascii?Q?isZvK2UDe1QW5w6MwGKQecqGDLAfDa3jBzpldTddWLzbDa5s+cHgLpE02TYa?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04B912DD119C3E4F92975EAB8B910769@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056d72a1-abb8-4fb3-18fe-08db3b676272
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 15:05:42.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: js9kBWB3h1qMPam+IpZR2SM6DypKCaeTmBNRKbbWplgFith+xfM4NVokPGJTTsBLuo/QCzg6pkoZsz+RJtT/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5415
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 08:50:50AM -0500, Rob Herring wrote:
> On Wed, Apr 05, 2023 at 03:30:27PM -0700, Daniel Walker wrote:
> > Describe the compatible properties for the Cisco CrayAR SoC.
> >=20
> > Cc: xe-linux-external@cisco.com
> > Cc: Marcin Wierzbicki <mawierzb@cisco.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Daniel Walker <dwalker@fifo99.com>
>=20
> checkpatch.pl complains that the author and Sob emails don't match.

I'll address it , assuming I send another series.

Daniel=
