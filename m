Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC26698F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241638AbjAMNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjAMNq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:46:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA05E093;
        Fri, 13 Jan 2023 05:40:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+RvfWSnTRaB/bQA/HW40H2AyzT/b9ULdg1UXqsPl/WGkV/aGBhWnyfmtQTqwTSUcE8xsTqsruTe+koLX27yRAFGguWU8mWG5JMSVo59GW+S/LjBBOfOvhzBMB7HyOQ/nqQniLBn6xWDe2RB3maSUc4We1jlcasyL7PhNW6P01sXu/H+vJ2dNoHrcZl4tl7fm2GlgcIu3ZhD/ry5djrAiLgQCPdjkR02Ve7Wyly/2VQ0ou+uMuO5D+VjWqob7WHuUrYlZt95QFp4od0wc2S2xq01cL9zmlmBHcOhvuVjAJq/iiBiTaQP7UjR9X4vWze93RA2qAQfIkGDXKOr18R3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPT+XP8Lp4eFki6YHoEQd22Po/zA5nsslrV1vkEBSS8=;
 b=QQvW0gGRKsPaIbFfuIlp1+NkRzk4YgIFRiiLiS9GjM+wi71Xbuf266ScIhwzKQPM4pmuUeng9JQsmklv4WnonyY5qZFcZRKIBjdVrY1oV0ePdTFmumSmF5ot/AJ+OXTaw/OU0KkajtH8g91vI2FUKTPiSEMLZBnLRylFT/7cLpBoW1RWzKhrJv7r/+vschx++yhvupDXrRkyr/W+0XS9CJ/4bGtF3650wVvnMs7BkpeWrXm7Pl17vclSR7gFXTG2prJ3+k3YsDsjLkvP6FML4leG7zbfFizRaCSP1jA5LkiCc6wVNswNRiEVMcaRAu4QZCp2UBypuQ5e8PFSVgtnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPT+XP8Lp4eFki6YHoEQd22Po/zA5nsslrV1vkEBSS8=;
 b=gS91bJgmy4Wxew/8+IWuIyIBFN7a+b2Mk+NgzQ161ZapS9Qa0ACIKfrMy0EYEOv0rxVIoW+6rgFhk3bAnCdU3p4MKrW4N9aMctXFR9NyP/yiDKfrWJH7etB/TH+qNQNKXuEKar0gyEiNkBf4KpuT0dXcbWul6EsKtqZta5nVrRQ=
Received: from DM6PR17CA0020.namprd17.prod.outlook.com (2603:10b6:5:1b3::33)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 13:40:10 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::b8) by DM6PR17CA0020.outlook.office365.com
 (2603:10b6:5:1b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 13:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 13:40:09 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 07:40:07 -0600
Date:   Fri, 13 Jan 2023 14:40:04 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Fix Payload Length check for Get Log command
Message-ID: <Y8FfNA2Se9UIVJAJ@rric.localdomain>
References: <20230104202954.1163366-1-rrichter@amd.com>
 <20230113115354.00003d5a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113115354.00003d5a@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b34a0a-a0bb-4e05-3e27-08daf56bb068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o9K2bu/j394JavZDuyaiMiU39Eh2y8VYEV7uYUo16KSfhXyI/Lb6VYMeC/a3iD7HqdkbHKcMkCzOvqdtma+3UM2076QdV3rDbnnlwHArMebtdIGvMcQdrqYXiaUV3Ym5oIiyX9PagOYuQ6HAEZYR5RMK6/dUOgAPajvT78gvdEFl02VJ5F2IfIMkAptw6wAF8WPddvdMfMi17eqiLhv3ZnGwk8LHQg7k0BMeaU0XeNsCHn4pYdPU5MvltOsBP1LAEcDo28lai6wF03+X0/1PoaUMCf12zr3i+Vzal2m8BWi5qEWZ0cmsiR5r8HaEB9f7OJX8YvLcm+lREG43zrKswh500v65pyxJjuq7Hg3KjlI58Fp7cgxsPLz0CYCGP2rP5JBtrxsRd7LmtLydcFMLGa3A+rOfUGOG98O6ZgxS7SyF/jTjyaQlm2JiPW7SsZ8q7hOfO15aHvGE+Q5Pm7v5O7a08MJcY5GBKO6utTVqE1gQaLp0bVMYUrrzlWY4LtmKn25DnCF0rBhtTi69uRYEgybE0ZYlwyTjqJ6JvJOoQLhzQKViHukoacvR+4H3GZb+cwSboU+HacrgIuQRXOq/fR3rjg8P8WxapPYQw31tIz47qzWZd90L9HjELf7I0de5UkB3e57VXfQwuqpvlXeEnOtWNRuMap26b7NLBTSx3IMLOiXYZg2+m426RlNEQHKviid9X9WVpwCX9FC+JPKlmzZDiXT1WLE8KkfA5UVMkk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(8936002)(55016003)(40480700001)(5660300002)(336012)(426003)(47076005)(36860700001)(41300700001)(7696005)(83380400001)(26005)(16526019)(9686003)(478600001)(6666004)(53546011)(186003)(8676002)(82740400003)(70586007)(316002)(70206006)(82310400005)(6916009)(81166007)(40460700003)(356005)(2906002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 13:40:09.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b34a0a-a0bb-4e05-3e27-08daf56bb068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.23 11:53:54, Jonathan Cameron wrote:
> On Wed, 4 Jan 2023 21:29:54 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Commit 2aeaf663b85e introduced strict checking for variable length
> > payload size validation. The payload length of received data must
> > match the size of the requested data by the caller except for the case
> > where the min_out value is set.
> > 
> > The Get Log command does not have a header with a length field set.
> > The Log size is determined by the Get Supported Logs command (CXL 3.0,
> > 8.2.9.5.1). However, the actual size can be smaller and the number of
> > valid bytes in the payload output must be determined reading the
> > Payload Length field (CXL 3.0, Table 8-36, Note 2).
> > 
> > Two issues arise: The command can successfully complete with a payload
> > length of zero. And, the valid payload length must then also be
> > consumed by the caller.
> > 
> > Change cxl_xfer_log() to pass the number of payload bytes back to the
> > caller to determine the number of log entries. Implement the payload
> > handling as a special case where mbox_cmd->size_out is consulted when
> > cxl_internal_send_cmd() returns -EIO. A WARN_ONCE() is added to check
> > that -EIO is only returned in case of an unexpected output size.
> > 
> > Logs can be bigger than the maximum payload length and multiple Get
> > Log commands can be issued. If the received payload size is smaller
> > than the maximum payload size we can assume all valid bytes have been
> > fetched. Stop sending further Get Log commands then.
> > 
> > On that occasion, change debug messages to also report the opcodes of
> > supported commands.
> > 
> > The variable payload commands GET_LSA and SET_LSA could be also
> > affected by this strict check, but SET_LSA cannot be broken because
> > SET_LSA does not return an output payload, and GET_LSA never expects
> > short reads.
> > 
> > Fixes: 2aeaf663b85e ("cxl/mbox: Add variable output size validation for internal commands")
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> Hi Robert, a few comments inline.

Oh, just found your comments here after replying to the other mail
thread.

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/mbox.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..e93df0d39022 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -170,6 +170,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> >  	out_size = mbox_cmd->size_out;
> >  	min_out = mbox_cmd->min_out;
> >  	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> > +	if (WARN_ONCE(rc == -EIO, "Bad return code: -EIO"))
> 
> This is unusual. Why the WARN_ONCE?  How can an error code
> be bad?  It may well panic.  Fine to have a dev_err() or similar
> but this seems excessive.

This function should only return -EIO if the size is unexpected. The
mbox_send() function doesn't have a size information and should never
return with -EIO. I think a comment is need here?

> 
> 
> > +		return -ENXIO;
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -576,6 +578,17 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
> >  		};
> >  
> >  		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +
> > +		/*
> > +		 * The output payload length that indicates the number
> > +		 * of valid bytes can be smaller than the Log buffer
> > +		 * size.
> > +		 */
> > +		if (rc == -EIO && mbox_cmd.size_out < xfer_size) {
> > +			offset += mbox_cmd.size_out;
> > +			break;
> > +		}
> > +
> >  		if (rc < 0)
> >  			return rc;
> >  
> > @@ -584,7 +597,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
> >  		offset += xfer_size;
> >  	}
> >  
> > -	return 0;
> > +	return offset;
> >  }
> >  
> >  /**
> > @@ -608,13 +621,11 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> >  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> >  
> > -		if (!cmd) {
> > -			dev_dbg(cxlds->dev,
> > -				"Opcode 0x%04x unsupported by driver", opcode);
> > -			continue;
> > -		}
> > +		if (cmd)
> > +			set_bit(cmd->info.id, cxlds->enabled_cmds);
> >  
> > -		set_bit(cmd->info.id, cxlds->enabled_cmds);
> > +		dev_dbg(cxlds->dev, "Opcode 0x%04x %ssupported by driver",
> > +			opcode, cmd ? "" : "un");
> 
> Unrelated change so doesn't belong in this patch.   I'd also split the
> dev_dbg into two paths both to reduce modification and because people
> might grep for "unsupported by driver"

I will send a separate patch for this and also rework this section.

> 
> 
> >  	}
> >  }
> >  
> > @@ -695,11 +706,12 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  		}
> >  
> >  		rc = cxl_xfer_log(cxlds, &uuid, size, log);
> > -		if (rc) {
> > +		if (rc < 0) {
> 
> Feels like passing in size as a pointer that is then updated might be cleaner.

I can do that.

Thanks,

-Robert

> 
> >  			kvfree(log);
> >  			goto out;
> >  		}
> >  
> > +		size = (u32)rc;
> >  		cxl_walk_cel(cxlds, size, log);
> >  		kvfree(log);
> >  
> 
