Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B155EDA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiI1Kcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiI1Kcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:32:48 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFE98276B;
        Wed, 28 Sep 2022 03:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTskxocmUzXDpYm9j+pAEc8Lgc+xqCLxucZEzCr7EnG4P+mlyqZwSefuP3KUMWSXh0nR1SfeofU1hXTDUNvUJbQ0MfJuobnKYPk6yBMT0qOcm6xvXl/Z5Sh0k3Wp6tgjqnCQcS4d6Ur087K3VC3E8bk8yqjJ6dRNtTiI0WWYmj0zyJXgUm4U/qy3n37KdiTtl1scwVg3zNPU0oO72h64H2R6xQz0tdVcvMlyOQSco2F1dkIwpbNSwFjFnMyty98UYaXf3x2aQT2usQ3Q0N83Yo1N7cT4owYGicLwRPpLbpRC6gKobjjYbldar5hsryldnxKgUk7XhMs4AhN6b9/V8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qz3Vu/V95T8vPrn8mf93248xPhs008FUB7mc18mKkc=;
 b=cDMIoa2+dSaR/Q9uBhQqJk1ejT/xyeL9TKqb6H6EuCCKurm3nMaRSFn4QWjJdiA6cidrrO/cNnBkM4G0VOs8VWLDEokd6Q0GrgKX3eIOb481uQLxWvZfjEX/6zTHt7rQF3W0RkrU5+Fip6UecQxRahySyaB+G13LCacrG9mOa2cp+J+dmQcgmgxMBaXmHu80rWDJXZN18DlA9AyyDyeClJWgj6xi83jD/jF4kRPF/tIvv31BnqCt/cEX5K8MWN2zBeWs/JRnX2TvoJ0p8flIx3PDtLHxfvjgty6zGSEnpZUkKias5DZ9+OSjH8dlDiAhSxm114RBdntzESZbAnIJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qz3Vu/V95T8vPrn8mf93248xPhs008FUB7mc18mKkc=;
 b=uX/VeD3l2ps38PglkzzZs5AiB59QdrIe/SzeybTQgZHzXG5720dr+dpFOMWZOZ9OnxCWY3WgAbY19090yTS2GDPaCo6aX6tkFDY7VhnvE0IC5U6N7VsOx935bLi5u+SZ4CifLInACplxYjyGUiCyvBEl1XB97NAInug1IhzuDiA=
Received: from DM6PR05CA0061.namprd05.prod.outlook.com (2603:10b6:5:335::30)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 28 Sep
 2022 10:32:44 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::75) by DM6PR05CA0061.outlook.office365.com
 (2603:10b6:5:335::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Wed, 28 Sep 2022 10:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:32:44 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:32:38 -0500
Date:   Wed, 28 Sep 2022 12:32:31 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/15] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <YzQiv4oB6ZnpOsJt@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-4-rrichter@amd.com>
 <631983487d3d3_5801629418@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <631983487d3d3_5801629418@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac9aaa5-d1ce-43dd-9e7b-08daa13cc790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TNgmC9Camu1M3RJSfQkR0PUcaUeXL4pW7Xv+YhYrpoE16zlTFjxoTh/WzvSbaBHI80kplASLTY20T7Th+ONuPUwTOoYuNta/hgMCkkcg/KwqpfHYV12miJqvgJnNIpj/SpAcaKYy8nQhgMUb/Htfzukr7mvItWYlRoHWBe/lrRzg/wE0FGqZqF4fWMHISYL3+R4dYvdFJU7yfWWnsYL/zUXBDFhYV3oMwIDWmpx0YSrt4Hy5hLdgCbTKTS87ESrTSqHqaRM4w/ckONf7AOH5d8TOUbDlECxUJw9gUl1347Hwfho4yhFA6dnAhtjXaxetyEAGs0ffERS174DdaH+dexPCju81UfJoye1Ehl0njJEPkKqnq6a4YoCprVcKhq+1Udl5DfJclmR+UrpKkpkQVy6h68wDaB/e1FZjJ0BsCz+cPEheWM7WI7i54NLSJwWgWPZEhrJSh40cC1iBMEaRF1B+kEhh5Lk5MygOjbE0ZXtJIFW3qsVLyXqp5VhZhGByxYnkIsdSpJnoP5yGydHzFUGxtB1v33+9bhN93CFVN3iU5DYog/zVkUyQVTXdLS3GeDn1CFHYNwJi1iuhavZl2Rd2d7J22G+Je/PqVVr51MRlQG5RnoPjg1zuokj4witw3XPiufGm6UyB3ge2/xCBANIOMT9KXmJYerHnheY9Tq/pHpN28V0iA2I0Rk+bWItTNYd+eotSUXyfB53tNv22IPHVzGzbCbtrAScKZ2sCq+yo23E0ALwllC02nPOVPVcwEMpCcC/tDE9TWel/YKBJKWeCa2hT9BWuH1tzrsSL78=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(4744005)(8936002)(82740400003)(81166007)(7416002)(2906002)(55016003)(356005)(7696005)(9686003)(53546011)(41300700001)(26005)(70586007)(70206006)(40480700001)(6666004)(4326008)(316002)(82310400005)(336012)(16526019)(8676002)(5660300002)(426003)(47076005)(54906003)(478600001)(186003)(6916009)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:32:44.3506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac9aaa5-d1ce-43dd-9e7b-08daa13cc790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 22:53:12, Dan Williams wrote:
> Robert Richter wrote:

> > +	parent_port = parent_dport ? parent_dport->port : NULL;
> > +
> >  	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
> > -	if (IS_ERR(port))
> > -		return port;
> > +	if (IS_ERR(port)) {
> > +		rc = PTR_ERR(port);
> > +		goto err_out;
> 
> While I agree this unifies the error messaging I am not a fan of what
> this does to the readability of the error exits. What about a compromise
> of renaming devm_cxl_add_port to __devm_cxl_add_port() and add back a
> new devm_cxl_add_port that does the unified debug messaging?

Ok, will add a wrapper.

Thanks,

-Robert
