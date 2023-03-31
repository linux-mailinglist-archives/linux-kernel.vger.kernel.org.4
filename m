Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F236D1962
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCaIHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCaIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:07:23 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F3FA1A97B
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:06:58 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ACCEC244EFC;
        Fri, 31 Mar 2023 10:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1680250017;
        bh=89B8Z+Vvc0fsq53CV+d3qeFh5WYgM/QfWoN+C2pAxTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHxgu3jkjaWw6pnZ3jXyQYMMKYypE0z9PSwZpb8GNc1UIpK2R8mCaEfWJDJSaUr3K
         cZmdGV4fhUmyR2i6+jfKTKFvus1Q2BxSSV2FUPK9/aUKJBYrP2P+knEawug+C8ewCn
         3EX6Iepu7waPRbC1gOs9FrrlNPkx6wUesp+x/AM9XkjSbc0K8m1CSSmJLgglDVGe+Q
         raUpv68cf46Sw16s344r3sqPd4ZGk137jlyvUobD26JNeeFhDanejcBXw9UkqfpY1p
         tIzzH/njp6NSlZK3ebP5FV5ndD9KlNv4xQ/mzWFLMniMxr5cPm17xqwbfWfbzwA6xe
         0igxVYH3sYJXA==
Date:   Fri, 31 Mar 2023 10:06:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.3-rc4
Message-ID: <ZCaUoPMdgyWtPt2O@8bytes.org>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:47:18PM +0800, Lu Baolu wrote:
> Kan Liang (1):
>   iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug
> 
> Lu Baolu (2):
>   iommu/vt-d: Remove unnecessary locking in intel_irq_remapping_alloc()
>   iommu/vt-d: Allow zero SAGAW if second-stage not supported

Queued to the fixes branch, thanks.
