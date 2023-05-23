Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A470D405
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjEWGcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEWGca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:32:30 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E75EA100
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:32:28 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 2B37824819F;
        Tue, 23 May 2023 08:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684823548;
        bh=lDZD3zzGrByAcwmUfn2k+Bv0ncFvLlgDZU7+Qxs0X6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bj1hp9MuQ8xPbY1sKM2Qo+DaAR/9V51A2/8bML1yndoTmcK1P2svZ8kcn9Z4lCG9F
         iYhrmFL+ah2BH5uo7YwQ/WcCeHlIQHA9QX79dkJjMwWjG6jgw9H6/cqt0FQKuMl2Eh
         /dKm9ZLM0xoNdmlJq9PtDsx5fCL42hUE8NNWMX6Ae7ucdJmkd36yOr5nOl/K2CqO2x
         AzR1uNHoS1wQMh/YP5Z9Lj4GTXPLDZWwAFYv8K08PFMkgDl0hoR6w1jIypllLTHOiH
         Aw7XopLfkKsBcCLoAZKqGPo5NdQNZPdc5VyRBQ5b4o1MqpZ5BAWsZQZEXeV40taur+
         Ge1z+RJnfz3uw==
Date:   Tue, 23 May 2023 08:32:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc:     jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
Subject: Re: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable
 IRTE caching
Message-ID: <ZGxd-4mKvSgmYCvN@8bytes.org>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
 <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
 <700f08ad-0eb6-4ad6-329b-fe5b9cdb6a4f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <700f08ad-0eb6-4ad6-329b-fe5b9cdb6a4f@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Tue, May 23, 2023 at 10:38:59AM +0700, Suthikulpanit, Suravee wrote:
> Joerg, Please let me know if you would like me to send v3 with updated
> summary.

Yes, please send a v3 with all updates included.

Thanks,

	Joerg
