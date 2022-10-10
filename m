Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3D5F9B55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJJIqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiJJIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:46:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E3659D9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgTFgLML7ftpomyo1pbBC+6XMwCY0/MeqnrvRvk2SPljdUhH0CXMEvgpHjeTLDfnYNsRJUUTz9DlqSCEEBX40Lc+vnOcglUsC6ySgOp/o702BmPde7p3L901ChJHN48l4Hd0Ai6SkgzJAEF78iOoWoIZptprjwjO13DXjRLDRwpfS/GtAQMRG7SjMD1JrunVc/aLVzcdMq2S8f3/zc8S3GKGic7lFDVjImyN8eUCSv4eBh6cK6ehzI4CCM4sjCdgIgt3uUcBBk3wZc/qyCGrJ9iq0Z4KWyUiMbwgdO5w4G5r3rS7MH/ZRaKAi7hkZmIaEOEPPzFCNN/m2rUv/4/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3F4/Mg5QZArYB53vsIqqIhiUrWNKzG4L7HrJ8U7xVU=;
 b=Se1Z4CFSDnTVs0Gf6ea80kNm+07xHCBfFpi2ibHyWuaWqkCrBQ3vtDVHdj0cRhTffFt+aCtn579Tt/zVJOadpfMfE7f/YsejmhbjDgFO+F7Ys7WN3B1bXZrp0fWQ/518ArNbkr0KBXeaVePAlnlZimWP+HhuPU0Gfrxj7EQUgbMcn4OQwyDKQWe5QIlVOAQYQSPC4ayausoYlXg6LRLB0IbgARlhzrXPctQnWbuZQjXKYCdMtMt32S+gpDR8MsxEFFbJjxjPAgWXMLVK0yVF9m6JXbMDJTDoAa124IVh2qTzf49UIwg8Tr22WcPiCln2lhFNeEKeHYaWvowyyijQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=alien8.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3F4/Mg5QZArYB53vsIqqIhiUrWNKzG4L7HrJ8U7xVU=;
 b=ahcKejpz6ulUWKDfkg6pMqVpLNEhTnTgZNgDN/wiqKDIYK73lMdOJ7Jo+OQ5k95/YxSy4tz/vDSniCiVipqFFAGFK9PXjPB0j8hzE4YzJPguhA5BPqc/GqWMp/MS0WJd0QfFt+5QArZOEx+ZPjnRnHCnc5rl10grp83wkmb0FzLJbE/vEGOq5cXF1Be3jb6EY4v9LRh2O8PG+tNDmZ3YcSHlTkRxuPZ6AuKXXpdC3gA3uiFs3imoNPSZ9sDoOlrxBvbhpJbb77kGlIsHLW1fksIgtG4tHZ27W+/uOAK+WEaglbupmUrRt0UgG/VfvPkHQhZSH/J6NRs8Bc1SYEEnpA==
Received: from FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::6) by
 DU0PR10MB6108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.19; Mon, 10 Oct 2022 08:46:38 +0000
Received: from VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::ad) by FR0P281CA0140.outlook.office365.com
 (2603:10a6:d10:96::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 08:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT048.mail.protection.outlook.com (10.152.3.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 08:46:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 10 Oct 2022 10:46:34 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 10 Oct
 2022 10:46:33 +0200
Message-ID: <c4c35f8a-47ba-5e24-18e7-5190330c7e2c@siemens.com>
Date:   Mon, 10 Oct 2022 10:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] x86: Check return values from early_memremap calls
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Ross Philipson <ross.philipson@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <luto@amacapital.net>,
        <dave.hansen@linux.intel.com>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>,
        <jailhouse-dev@googlegroups.com>, <xen-devel@lists.xenproject.org>
References: <1650035401-22855-1-git-send-email-ross.philipson@oracle.com>
 <1650035401-22855-2-git-send-email-ross.philipson@oracle.com>
 <Y0GTUg1ACpKZYMHY@nazgul.tnic>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <Y0GTUg1ACpKZYMHY@nazgul.tnic>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.017700-8.000000
X-TMASE-MatchedRID: ObgwaKFsELAhz+KjBN9OufDMpLU9EzbQXKlUkWaHqwvx5KZMlKYS/XFa
        /hQHt1A1uSti1BoHqPa/jCH0Rcd4ASFDPhCO3zhjWO3sffakmrSULKc3M3OLX+ds4fnKv9CbT5y
        sQDj6eFk8cwBuO6HB35qG6AqjBmI1tQ6RnhDKnkCDC+22jz8Xi5v831J4kXLFsFkCLeeufNvESS
        xPxTa9gwaYevV4zG3ZjBYhGYtVarnOH38lNbOoTEwKCRzf8GZNB3U7YNIjWSM37vkU5XIl4IeAP
        CkZqxntBm9f7S94IJwlwoDYzPfxXyeOufXFPnmGPeqHl9AJspVMFlcbo5fDhC2416nc3bQlkYC3
        rjkUXRKUAUfla+IhaLKXWmEvaG3ElyyR46PvItPv291MwfmTC5H0YXYnbGozOX/V8P8ail2cIZL
        VZAQa0HhSEE8tGW+Gq7rFUcuGp/EgBwKKRHe+r+E2PD8v3QzJvTwTprSRTiLfqm6i3GCTZroQ3p
        6s8R2GK+LM6Wf90BQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.017700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 261D062BC881AE064030412BAF3C4AE581FC2F1906697EC91488ACB5DD6C9CAB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT048:EE_|DU0PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: f2630c55-55a4-4e17-920e-08daaa9bf1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04TMPTkG8DfTl/crYlea/0+mIoAQkz3AAvu6d2ZMBc8ZvRFqKpMv3Ve6B8x/W0zcv0Jw/RJilAGds0fR22cJok548yO4+VU3UM5wVVsDyJTHemVZAY4p2ju4BZmLrYaIvs+PO6wD4LjSZZ7MF+uNVPtH986pEinFSCuXwh34Q/w7FSqMNcuWLoBdfGzB9UWrJSxIbWfdddvRx7Irpuo+BkFRR4zLm8hQlW1Ai+x5HDKWG0+38aeAXZOgl7Dv3HWb7Bh37t0QF0OD+LSd6qCz+qG2ncgSvpJeFVWUC5s0bUYIXSrMlHTlY9PTb4f5ydhNL111z6q669I2Z8TRpzo98dxiJmDdp9TIpKxbF4RRlsADVOk04NH88rPRr7du9KYlh9+GPk8igGX05heEq/+67mioOaSAeocrEmdJiagfleqww8LCAUouXQGD0a5MT1ZtVN29DZUMzXTR5l/YQeubpxMIAqVwk3v+hFG69eLTJYGlFClD5STtrY/xlqtzJMYBMUU5okCjAOiGSNw87e3HyioI8msAIr42pooZbWQBchYb1uCpJ00xfMO1coY4TGIt6Egm5mqcOWP1ercbr4u3Mh92aTRvnkKV22UUr8jaxwWCGdfLMlvagvlVoPdfJ1yP+kEHoylDGI4hGAdvOmZttfRxY5cARrolX3FQHXQw2QfqSxHd7//6vT+QrFN9tyhZGBS5poQssczx3MXkWEm+tTldPtJVriTL0V5LdUN1Ozfc0O3ccm05aoC2nyk4zpRSzUpcm6sXNlaZfsNIldFnOGtlg/8xZaGgFd93kNBweufmTy7BLn7X5q8/ArKc1ged4yDuK0Q6SKm1nTerBMktIDgZbbOS9GWMEgfTaPxGBr2O4+61GzybcWpOGbJxYJg7YxpiTvqBAxIb39Pl+KAnDg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(36860700001)(82740400003)(316002)(8676002)(6666004)(31686004)(82960400001)(44832011)(70206006)(4326008)(53546011)(26005)(5660300002)(956004)(2906002)(81166007)(336012)(31696002)(40480700001)(70586007)(6706004)(2616005)(186003)(54906003)(41300700001)(16576012)(966005)(83380400001)(356005)(110136005)(47076005)(40460700003)(16526019)(86362001)(82310400005)(8936002)(36756003)(7416002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 08:46:37.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2630c55-55a4-4e17-920e-08daaa9bf1bc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6108
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.22 17:12, Borislav Petkov wrote:
> Adding Xen and Jailhouse people and MLs to Cc.
> 
> Folks, thread starts here:
> 
> https://lore.kernel.org/r/1650035401-22855-1-git-send-email-ross.philipson@oracle.com
> 
> On Fri, Apr 15, 2022 at 11:10:00AM -0400, Ross Philipson wrote:
>> There are a number of places where early_memremap is called
>> but the return pointer is not checked for NULL. The call
>> can result in a NULL being returned so the checks must
>> be added.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>  arch/x86/kernel/devicetree.c | 10 ++++++++++
>>  arch/x86/kernel/e820.c       |  5 +++++
>>  arch/x86/kernel/jailhouse.c  |  6 ++++++
>>  arch/x86/kernel/mpparse.c    | 23 +++++++++++++++++++++++
>>  arch/x86/kernel/setup.c      |  5 +++++
>>  arch/x86/xen/enlighten_hvm.c |  2 ++
>>  arch/x86/xen/mmu_pv.c        |  8 ++++++++
>>  arch/x86/xen/setup.c         |  2 ++
>>  8 files changed, 61 insertions(+)
> 
> Ok, a couple of notes:
> 
> 1. the pr_*("<prefix>:" ... )
> 
> thing is done using pr_fmt() - grep the tree for examples.
> 
> 2. I think you should not panic() the machine but issue a the
> warning/error and let the machine die a painful death anyway. But Xen
> folks will know better what would be the optimal thing to do.
> 
> Thx.
> 

For the Jailhouse bits:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

(IOW, panic'ing is fine for us here)

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

