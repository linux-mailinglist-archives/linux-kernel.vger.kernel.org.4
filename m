Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5E62E3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiKQSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiKQSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:14:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83789B64;
        Thu, 17 Nov 2022 10:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3BqwORfOF0g+oThwW5dScFk9C/Idlh8BgEdz7fUugqfG/yhpmJh8i3iuEMvgG5HAypumGqdxyL0ib6jN3nVbpjkS69Fw8RyD9CROkABlbs0FVmu8R+XJF+gIhnJ0k5XEaUsQ35kcshH9fi8wM6rz/MpZPlVlChBr6rU/o15iBRXDsjo4UzIvWa5dJrwJ6fZAJT/ud+6PRFwyz5wRB/Uhl1ang62ZpFRg8SqCmzRzXs5ymtiQIVclFA/7ZBsA9YN5ezZwg0NVd7jxoIPPGAlbIHrzspFR+UDzfXr10ad+NY3EDLtfXfRMp3Y4hEK+29Ft6ClTtVj8iQQo9guAVC9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh4hRVZ+TuFpIpeoN4Cy8vDqTDXqhfLmjthxmNbWB7k=;
 b=G3XNjLPShMzd6OLOf+oOzSHCBtxasElkJnjMX/QHpwMXGomGXXQSdUDBkqBZEHe445KNyPayA9HIYa1wTVztdJ3w48w1L4kBBN/gjXFNvoCvO5fiCKU31A78z1+rR2ATu378lgyaA9XjlkQPJGx+dTidviwgQrxktmu06NstZSUtQ3bmYe43da05QMMmWQXxb0CDIIfIa2Vd2qoRh5RfC4KHPok3WeVhJLCjkHwEWXmAmMHpeOoQCmt9XRdTpef0+yP04VGIJMtZejA5auUSZKd/+X4+TW/GPqTmXf9c1mApWSCkx711FKuzLs4iXBIUEFo5dpbxarCqmWO+jAY3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh4hRVZ+TuFpIpeoN4Cy8vDqTDXqhfLmjthxmNbWB7k=;
 b=Fuh6WgwZ8VlMUHJx8vrSJH/gmhK5u+Gn5T08BDTo40g2NEoiHG4vnwi8ai+XNUfcUpdWdihZcinrBBCs1QqlOqQy/YbehKZ/f2Znri/t8IxGWJkfC7rVPaXMxy7nPa81oZQtOrp8KNRtL9X2MGtUwbO2/94CH8PBRdBfL5oKVKI=
Received: from BN7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:408:34::14)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:13:20 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::11) by BN7PR06CA0037.outlook.office365.com
 (2603:10b6:408:34::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 18:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 18:13:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 12:13:13 -0600
Date:   Thu, 17 Nov 2022 19:13:11 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 3/9] cxl/mem: Adjust cxl_mem_find_port() to find an
 RCH's port
Message-ID: <Y3Z5tzp66HmJy3Cd@rric.localdomain>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-4-rrichter@amd.com>
 <6372d30ef4152_12cdff29452@dwillia2-xfh.jf.intel.com.notmuch>
 <Y3OQUAriOj2NxLfO@rric.localdomain>
 <6373d524a1a1b_12cdff294e7@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6373d524a1a1b_12cdff294e7@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: de0e2482-d049-4409-61da-08dac8c76855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FM6MfP09kG0iQuGSpI05xyudD5u0vnFBYJ53dKjJj2so+WIeJ9FTHI0rlfh7t7QzId+8HrQeoQfk7VCHTvU04AOt1OUBcwlbkXJ12Xbk+AryG+3vP9ZoXnQblxEq4l/mMbtmdjB838gOXltwLgIb/G5fsLkewOlqHSKlTJQIE7z621ud1BNslP20WlUYOQqKQMhPJ2J+E9wD/nJxI6EDThfpDNkJ345OZiji0kIwAe/X/KXFI5xGA8vPN35wZjmGoBbIIdluYXAtHjZ/bW61nwCLUdqAfpitUVdE8HeQuL27Y8UKA1MvUCkgeL4n6zbdYAv6L9pwZzwkeNABls/HX5EBwYgDipLYOp7B/IE0rtRQVBwpFzy+Rj/ppoIEyUpLyjK7LetsZ7puzvZ2ee59a1cSNjNwhggxShb5pXQ3Li3f+n7GrjUdKS0NhrPiGCkQpCv+5TGSB7/aWhcoGKN56TBTY4i0ly0fUETn/yyCgB3DmVPUGPllT6HYEQjwQtNt2WswY4hqtH3AjGc8M8FOTWKzW2zAZd5Tjsu+qeRIFjeb7QvNdFE2D4xZmWcBh+SsSkZ81JM0fc2z6hjZSpeyUnEmZvLymFRWvuvD/ijdcicnSS2JsHZ7xsrA53kh0KxXdRaJCdfwphsSLG85GWilrshyqL9DKeSL7GXWP8PjzyX0HO5pphy+6EU9P70GR95vq62SDAHbpH+lTat+OgMOWhylab6c0JXyCjFdIoJ0BWZWOdSvfunmmLiRf9G3OB3xxHuzcMXgxm62aF6v1XJjeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(26005)(6916009)(7696005)(41300700001)(54906003)(2906002)(53546011)(70586007)(70206006)(9686003)(4326008)(8676002)(186003)(316002)(8936002)(47076005)(5660300002)(426003)(336012)(7416002)(16526019)(36860700001)(82310400005)(356005)(82740400003)(81166007)(55016003)(40460700003)(40480700001)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:13:20.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0e2482-d049-4409-61da-08dac8c76855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.22 10:06:28, Dan Williams wrote:
> Robert Richter wrote:
> > On 14.11.22 15:45:19, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > The PCIe software view of an RCH and RCD is different to VH mode. An
> > > > RCD is paired with an RCH and shows up as RCiEP with a parent already
> > > > pointing to a PCI bridge (struct pci_host_bridge). In contrast, in VH
> > > > mode an PCI Express Endpoint is a PCI type 0 device with a PCI type 1
> > > > device as parent (struct pci_dev, most of the time a downstream switch
> > > > port, but could also be a root port). The following hierarchy applies
> > > > in VH mode:
> > > > 
> > > >  CXL memory device, cxl_memdev                               endpoint
> > > >  └──PCIe Endpoint (type 0), pci_dev                           |
> > > >     └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> > > >        └──Upstream Port (type 1), pci_dev (Nth switch)        |
> > > >           :                                                   :
> > > >           └──Downstream Port (type 1), pci_dev (1st switch)  port1
> > > >              └──Upstream Port (type 1), pci_dev (1st switch)  |
> > > >                 └──Root Port (type 1), pci_dev                |
> > > >                    └──PCI host bridge, pci_host_bridge       port0
> > > >                       :                                       |
> > > >                       :..ACPI0017, acpi_dev                  root
> > > > 
> > > >  (There can be zero or any other number of switches in between.)
> > > > 
> > > > An iterator through the grandparents takes us to the root port which
> > > > is registered as dport to the bridge. The next port an endpoint is
> > > > connected to can be determined by using the grandparent of the memory
> > > > device as a dport_dev in cxl_mem_find_port().
> > > > 
> > > > The same does not work in RCD mode where only an RCiEP is connected to
> > > > the host bridge:
> > > > 
> > > >  CXL memory device, cxl_memdev                               endpoint
> > > >  └──PCIe Endpoint (type 0), pci_dev                           |
> > > >     └──PCI host bridge, pci_host_bridge                      port0
> > > >        :                                                      |
> > > >        :..ACPI0017, acpi_dev                                 root
> > > > 
> > > > Here, an endpoint is directly connected to the host bridge without a
> > > > type 1 PCI device (root or downstream port) in between. To link the
> > > > endpoint to the correct port, the endpoint's PCI device (parent of the
> > > > memory device) must be taken as dport_dev arg in cxl_mem_find_port().
> > > > 
> > > > Change cxl_mem_find_port() to find an RCH's port.
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > > index 0431ed860d8e..d10c3580719b 100644
> > > > --- a/drivers/cxl/core/port.c
> > > > +++ b/drivers/cxl/core/port.c
> > > > @@ -1354,6 +1354,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> > > >  	return rc;
> > > >  }
> > > >  
> > > > +static inline bool is_cxl_restricted(struct cxl_memdev *cxlmd)
> > > > +{
> > > > +	struct device *parent = cxlmd->dev.parent;
> > > > +	if (!dev_is_pci(parent))
> > > > +		return false;
> > > > +	return pci_pcie_type(to_pci_dev(parent)) == PCI_EXP_TYPE_RC_END;
> > > > +}
> > > > +
> > > >  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > > >  {
> > > >  	struct device *dev = &cxlmd->dev;
> > > > @@ -1433,9 +1441,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
> > > >  
> > > > +/*
> > > > + * CXL memory device and port hierarchy:
> > > > + *
> > > > + * VH mode:
> > > > + *
> > > > + * CXL memory device, cxl_memdev                               endpoint
> > > > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > > > + *    └──Downstream Port (type 1), pci_dev (Nth switch)        portN
> > > > + *       └──Upstream Port (type 1), pci_dev (Nth switch)        |
> > > > + *          :                                                   :
> > > > + *          └──Downstream Port (type 1), pci_dev (1st switch)  port1
> > > > + *             └──Upstream Port (type 1), pci_dev (1st switch)  |
> > > > + *                └──Root Port (type 1), pci_dev                |
> > > > + *                   └──PCI host bridge, pci_host_bridge       port0
> > > > + *                      :                                       |
> > > > + *                      :..ACPI0017, acpi_dev                  root
> > > > + *
> > > > + * (There can be zero or any other number of switches in between.)
> > > > + *
> > > > + * RCD mode:
> > > > + *
> > > > + * CXL memory device, cxl_memdev                               endpoint
> > > > + * └──PCIe Endpoint (type 0), pci_dev                           |
> > > > + *    └──PCI host bridge, pci_host_bridge                      port0
> > > > + *       :                                                      |
> > > > + *       :..ACPI0017, acpi_dev                                 root
> > > > + */
> > > >  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
> > > >  				   struct cxl_dport **dport)
> > > >  {
> > > > +	if (is_cxl_restricted(cxlmd))
> > > > +		return find_cxl_port(cxlmd->dev.parent, dport);
> > > > +
> > > >  	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> > > 
> > > I do not see why this change is needed. For example:
> > > 
> > > # readlink -f /sys/bus/cxl/devices/mem0
> > > /sys/devices/pci0000:38/0000:38:00.0/mem0
> > > # cxl list -BT
> > > [
> > >   {
> > >     "bus":"root0",
> > >     "provider":"ACPI.CXL",
> > >     "nr_dports":1,
> > >     "dports":[
> > >       {
> > >         "dport":"pci0000:38",
> > >         "id":49
> > >       }
> > >     ]
> > >   }
> > > ]
> > > 
> > > ...so, in this case, the grandparent of "mem0" is "pci0000:38", and
> > > "pci0000:38" is a dport. Unmodified cxl_mem_find_port() will do the
> > > right thing and find that this CXL RCIEP is directly connected to
> > > "root0".
> > 
> > find_cxl_port() uses the dport_dev, not the uport_dev. A lookup of
> > pci0000:38 gives the cxl root (ACPI.CXL).
> 
> ...but that is what I would expect. I.e. that RCDs appear directly
> connected to the cxl root with no intervening cxl_port instance, and RCH
> host-bridges only serve the role of dport devices. This also matches the
> diagram from 9.11.8 CXL Devices Attached to an RCH where a
> downstream-port RCRB in the host bridge is directly connected to the
> RCIEP endpoint.

All devices connected to ACPI.CXL? IMO this needs to be bound to the
host bridge. The hierarchy should show a host/device mapping. In fact,
in a VH the root port is also not part of the mapping, instead the
host bridge shows up there. Also, there can be multiple RCHs.

-Robert
