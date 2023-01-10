Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC089663AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjAJIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjAJIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:24:00 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91843A1C;
        Tue, 10 Jan 2023 00:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWH1FwEl6B920TMBQVgKQxhNnJNAGX8bD6JlYAmbVIo=;
 b=1D0SzwHwbVWyt+rVkdRNHeTVhufk8TlYz1CuSMV/MDyZnyqpwe9f44scFxubdP1KAmoPC5MKIiyuxgbHlgqWCtqwm7rXBVcmfONoqDIaQW0tIkCEgA4hTyMxKuN5UpfJAelm9RO6klOsWY8f6EvyxM+XXaIgVjAOBAYHWohMQtA=
Received: from FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::8) by
 VE1PR08MB5805.eurprd08.prod.outlook.com (2603:10a6:800:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:23:55 +0000
Received: from VI1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::ef) by FR0P281CA0150.outlook.office365.com
 (2603:10a6:d10:96::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 08:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT063.mail.protection.outlook.com (100.127.144.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 08:23:55 +0000
Received: ("Tessian outbound 333ca28169fa:v132"); Tue, 10 Jan 2023 08:23:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8754c4674e03bb30
X-CR-MTA-TID: 64aa7808
Received: from eff62df32ded.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F36BA62D-EBA5-41D8-A6F5-216F1239B093.1;
        Tue, 10 Jan 2023 08:23:43 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eff62df32ded.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Jan 2023 08:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXWzLSw4wYjQPpTWmJkUzxeo9Uhu95BedpTydXbCJcefx6O9fBqHCH6/IhlT+bEk+IsinehYEO3GSEHra722+0QU5x4d4WbOKIjw1CgR5T+JjDY/W76ofqQpL2FpN2fMQJSc0sjh+rxwpl64Ke/QtDlMOnclwtWCas1qE388f6aevKXilOY6vR7Xc9FhfmWrTyxgYsOWBW9Sd4VLyeUgCVLZEhSi3a+lHXBIqiw4yAxa3WzcJkARpvmr/+WiA4Bu51aaPtbqg3wgeT+5v8EAbjYG24AJkE5yMgHzisEZwULtyVSAtKW9ND7gOEfpKjAVK/ZLj1SntC63vxM17PMAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWH1FwEl6B920TMBQVgKQxhNnJNAGX8bD6JlYAmbVIo=;
 b=jPqd89MUFdz3+pgowE6cd7bSTy7qqSR3m/qH3JS6/nzYnRMZWNv1ouXxy1h/wotklt/7g6s/g5qy50tJCIi5ME14qlPsBYUjjWTKR4S6CpqPf2kTvppaRcEHQC6S3gA2fwJKpgdLeDjC6w7U+YThuRjEikW+zSg5y7V3F7dg6D7iaj6ZZpTX/kFag7kmms+x5co4hcxV95MU/Mm2qAfYiYszqfaTI+pELRQbVrR6ixjv6ByjgyAIOZ7Y2BBx1LOG8lJGIwOspsJYADhNd5dESkgL/42Cmcn42NiQ9FHD37yosK8TyPe+6QVxXoNCF5Wq6EVTZ1sTCHjweNkIf2lv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWH1FwEl6B920TMBQVgKQxhNnJNAGX8bD6JlYAmbVIo=;
 b=1D0SzwHwbVWyt+rVkdRNHeTVhufk8TlYz1CuSMV/MDyZnyqpwe9f44scFxubdP1KAmoPC5MKIiyuxgbHlgqWCtqwm7rXBVcmfONoqDIaQW0tIkCEgA4hTyMxKuN5UpfJAelm9RO6klOsWY8f6EvyxM+XXaIgVjAOBAYHWohMQtA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB8954.eurprd08.prod.outlook.com (2603:10a6:10:465::21)
 by DB4PR08MB7933.eurprd08.prod.outlook.com (2603:10a6:10:37b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:23:40 +0000
Received: from DU0PR08MB8954.eurprd08.prod.outlook.com
 ([fe80::f778:5177:a2d3:ace1]) by DU0PR08MB8954.eurprd08.prod.outlook.com
 ([fe80::f778:5177:a2d3:ace1%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:23:38 +0000
Message-ID: <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
Date:   Tue, 10 Jan 2023 13:53:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
References: <20230105160346.29018-1-faiz.abbas@arm.com>
 <20230108163741.GA30997-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20230108163741.GA30997-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DU0PR08MB8954.eurprd08.prod.outlook.com
 (2603:10a6:10:465::21)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU0PR08MB8954:EE_|DB4PR08MB7933:EE_|VI1EUR03FT063:EE_|VE1PR08MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b694d7a-71cb-4a41-0b0f-08daf2e40396
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: D7HhoVfmg2EDc8lEMMwZrT+mwlrYVXcp6dYp/H+Y9y8DlJj61+K9gjnHYfQUFYk24KHeCgDXOSckxiBt7QLAaBReYSBHu/+vswa2jy4aru+Gy2HR4jT5eLsv28ioKiBiuMyyUfbAz2TKmkUa9SysMM1LeDEZlzp0kCanP0DkSyvIO51zsI8bMBy+ybrWC1WpIXLtHL4FDf5Jw+s0UvOt1nuE2I6BcwhIaKEXnIGVBVzHBNmWwRUWhoXSYFBHALkXq4S4Omozo0+4XKch7JfjE8CXgWMWWphikOd8RYG2d8aNJWbSNpEWcipu1OeZnhTMV2ivkRsul92fUQej6O5URXT81MWULiX5E/YnxBTeeLUUGKgC1AqHsGd/bd7cPvo2d2wycQ3NCki/+CHytCwsFGu/OpTc1R7fGFB8nd6bqbLOspz/9xv9eI2hX2gFZSYsAilimVNTXjuzs+VDDHcaB2FsDw44Gd9mgUvNl2KnrBxhnPYZwRPDWFl18UVq5SUfe5Kgt5j2rPrT6oFX2qxjKH8Z/gTqf6xe6VOQlMi4LYbeIE2+Ivgan37d9Xcgb5tJLPxYaNNfrZONV/mo0xWcM15hduk0j0wggo17IRijkjoFUlakrwPnIoTC6PGbPPxZQFHJHH2Kk7KDk53aVdfG2DAsX8PV+hj4sQ4AC7zngOv8vKxvQr2pBDEgoeXGVdvWHJAyDitTF1Rd9ZOWvgRw85QzHo52NQEWygHfJIEKAvc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8954.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(31686004)(36756003)(2906002)(31696002)(38100700002)(5660300002)(8936002)(41300700001)(83380400001)(86362001)(6916009)(6486002)(55236004)(6506007)(53546011)(2616005)(8676002)(186003)(26005)(66946007)(478600001)(66556008)(66476007)(316002)(4326008)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5f53d1f0-341a-407b-425b-08daf2e3f8d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: momcpREo4ytZtVF8VPqyMChhek/D1IO/XwrMLei9H/O9IRepmldLOFcdJL273+AxLgdNm78PGe5CArWeEn2h2CS7yn86Rhzi5Hg+OfkFCdJZZTPaSxSbfu2TTlQekBq/SZ1Opwil/lrgKbM3OLHfI0S9e2aVC89U4Zi4NpYr6Nt5goQGb21xzs2Noovp51zPOQcHkfFLn1j8izz6hv79HlrY7UEnT1AmSMQ0Fdo9ESULlMjTrDjm3QTf2nvNdGKdIBH55hIcKjmAT18HQ5fMkKYbo5hg4cwsGVGLtOm0jwIEQ6A6NiI9KPfStvNOFXK5cbKlLT9VmDa2i8HRtVbur4X3ACBU6Iifya6h2/dSffoHi1HE2yfx67Ze6VRrwK4fxvE4jL5S0oECR0A7k7oJDRDslGUVM/QtWnMFeHoyRUMbM5BitVodZmcb4Mz+VSarwbwep4zqvA2tn3xSj4g/WzjLLeVmj5uCQB+Z0UY9UFgjmb9FtkXyHrl9PkhM1IMBUL5ihiEDHj1g/fI9qydURRSfoawcIjz3p4PbPsF0s8Kh2VCUSlRK6Jlw29QUiv0liIyYWIaNFsQ0ye95mGIPMGD6Q7YuekbBsbKLHoxupvYbU5+t0wy37bDFpqEdsmal49k67w1R15ysvkUyrKPuvU0oBUruRHdjbPi1yWWsD3OgpAlRI57qw/FreRXMBw993dAtDIUIxlwUCmPg0FhsmmU78PGBTltJqLhSzGvShXY=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(6862004)(8676002)(8936002)(4326008)(41300700001)(450100002)(82310400005)(70206006)(70586007)(5660300002)(31686004)(86362001)(40480700001)(31696002)(6666004)(53546011)(316002)(82740400003)(2906002)(36756003)(36860700001)(81166007)(356005)(6486002)(40460700003)(478600001)(6506007)(83380400001)(47076005)(6512007)(26005)(2616005)(186003)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 08:23:55.1414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b694d7a-71cb-4a41-0b0f-08daf2e40396
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5805
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 1/8/2023 10:07 PM, Rob Herring wrote:
> On Thu, Jan 05, 2023 at 09:33:46PM +0530, Faiz Abbas wrote:
>> The simple card driver has support for adding cpu, codec and platform
>> nodes with the simple-audio-card prefix. Add documentation for the plat
>> binding.
> Another node, is it still 'simple card'?

This behavior already exists in the driver. I am just documenting what alre=
ady exists.

>> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
>> ---
>>  .../bindings/sound/simple-card.yaml           | 23 +++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/=
Documentation/devicetree/bindings/sound/simple-card.yaml
>> index ed19899bc94b..fa67c76d4dbb 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>> @@ -205,6 +205,8 @@ patternProperties:
>>      $ref: "#/definitions/dai"
>>    "^simple-audio-card,codec(@[0-9a-f]+)?$":
>>      $ref: "#/definitions/dai"
>> +  "^simple-audio-card,plat(@[0-9a-f]+)?$":
> What does 'plat' mean?

plat means platform. I'll make that clear in the patch description in v2.


> Don't continue the 'simple-audio-card,' prefix.

The implementation already exists. Its just not documented here.


>> +    $ref: "#/definitions/dai"
>>
>>    "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
>>      description: |
>> @@ -285,6 +287,27 @@ examples:
>>          };
>>      };
>>
>> +#-------------------------------
>> +# single DAI link with platform
>> +#-------------------------------
> Really need another example for 1 simple node?

I'll remove the example if that makes it easier.

Thanks,

Faiz

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
