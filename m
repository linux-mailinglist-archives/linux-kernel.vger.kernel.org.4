Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA796A6ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCAOsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCAOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:48:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786538EB7;
        Wed,  1 Mar 2023 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677682088; x=1709218088;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=dGvC9eGq5k6twTGfbky64yc6qOs8FI0yxPKb1YduYWs=;
  b=XOGyNiiyqA6xmqxJCGFdlJFr0EtHPbgKN1tpJkygPLlgq29t6aE9urm5
   tcEzrWOtYIi6kor4wVZutqGpS/WkzmahuTkN4HK0TkOMfEWyrUTzeKZXL
   wY9FH02L9551/oXrtQgvhQuco20zebpqijueyyTsTMqz08MmnsGFwsUwl
   sN15hMoJWTiTclG4ix0BGIMcxgsdSEpnLfflqzvWnFRiwhNQMy6o9LlB0
   zspG6qD0RVRH5uaP78gGRlQuWoylgZVdExA4amQlLwraddDujDVef9Qb1
   QDiEo81awaEir6p6kkhJN1IkpQr1Yp5QcuacjY6Emlf6L3WaMiKZM5tXZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314092016"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="314092016"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 06:48:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="784378464"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="784378464"
Received: from smeeranx-mobl2.gar.corp.intel.com ([10.213.113.101])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 06:48:06 -0800
Message-ID: <bc3ad416cf45aa1e8fe1f466a09a9388b0aaf7ab.camel@linux.intel.com>
Subject: Re: [PATCH 01/12] platform/x86: ISST: Fix kernel documentation
 warnings
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Mar 2023 06:48:02 -0800
In-Reply-To: <39b98cb1-1ef5-dabf-5f01-2f673b2b59b1@redhat.com>
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
         <20230211063257.311746-2-srinivas.pandruvada@linux.intel.com>
         <39b98cb1-1ef5-dabf-5f01-2f673b2b59b1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Since some patches you are adding to your review branch,
shall I exclude those from new series by rebasing on=C2=A0
your review-hans branch?
?

Thanks,
Srinivas

On Wed, 2023-03-01 at 15:23 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 2/11/23 07:32, Srinivas Pandruvada wrote:
> > Fix warning displayed for "make W=3D1" for kernel documentation.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Thanks, I've applied this patch to my review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/log/?h=3Dreview-hans
>=20
> I'll rebase that branch once 6.3-rc1 is out and then push the rebased
> patch to the fixes branch and include it in my next 6.3 fixes pull-
> req
> to Linus.
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
>=20
> > ---
> > =C2=A0drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3
> > ++-
> > =C2=A0drivers/platform/x86/intel/speed_select_if/isst_if_common.h | 1 +
> > =C2=A02 files changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > index a7e02b24a87a..63d49fe17a16 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > @@ -112,6 +112,7 @@ static void isst_delete_hash(void)
> > =C2=A0 * isst_store_cmd() - Store command to a hash table
> > =C2=A0 * @cmd: Mailbox command.
> > =C2=A0 * @sub_cmd: Mailbox sub-command or MSR id.
> > + * @cpu: Target CPU for the command
> > =C2=A0 * @mbox_cmd_type: Mailbox or MSR command.
> > =C2=A0 * @param: Mailbox parameter.
> > =C2=A0 * @data: Mailbox request data or MSR data.
> > @@ -363,7 +364,7 @@ static struct pci_dev *_isst_if_get_pci_dev(int
> > cpu, int bus_no, int dev, int fn
> > =C2=A0/**
> > =C2=A0 * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
> > =C2=A0 * @cpu: Logical CPU number.
> > - * @bus_number: The bus number assigned by the hardware.
> > + * @bus_no: The bus number assigned by the hardware.
> > =C2=A0 * @dev: The device number assigned by the hardware.
> > =C2=A0 * @fn: The function number assigned by the hardware.
> > =C2=A0 *
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> > b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> > index fdecdae248d7..35ff506b402e 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
> > @@ -40,6 +40,7 @@
> > =C2=A0 * @offset:=C2=A0=C2=A0=C2=A0=C2=A0Offset to the first valid memb=
er in command
> > structure.
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0This will be the offset of the start of the command
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0after command count field
> > + * @owner:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Registered module owner
> > =C2=A0 * @cmd_callback: Callback function to handle IOCTL. The callback
> > has the
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0command pointer with data for command. There is a
> > pointer
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0called write_only, which when set, will not copy
> > the
>=20

