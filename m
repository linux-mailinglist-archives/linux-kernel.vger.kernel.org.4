Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91B5FE157
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiJMSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJMSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:34:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C342116C220
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:30:50 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id z8so2254967qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zCYcw4r25uAhAazcpldbhB0FQKMUFrnZHLZzrH6Bdg=;
        b=Tr5c5ZHothFP0VNNAdB04vY3rPvYGVOMY+esav/H/ghKOOMtHhs6ZEylwCGnOIHpK2
         yrLsHqrQGtoX0KSDXT75mcN6EwyuD8gD3Ct8qv8fRU3eE0sWkNsgxckpfg+4i+mG5FBk
         elkNxQm13h+X3/smB8hdYJNRVI0YecjP7uFpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zCYcw4r25uAhAazcpldbhB0FQKMUFrnZHLZzrH6Bdg=;
        b=ASHlLZIVrnEwajquWKFu/HncECNiQg5hp7/4q1Yick6X0I3mvexyam0ERER2VNz1KL
         FLIe6ZBLvV3POJecouFmcgMPAWE9pNWhyRl/xesh0Jeya48pm4+ikNFmeBRLHIp1rqli
         TN29/Ohci9uaM+OyiCNRF8ZRKb6VIwbogyWlSE4WVTsYyoM6tDcbWiR4vcITeGkvK9Eo
         CQOYLssKJNpzjSRPOmTjJLqVNMNRsWDy7oe/W0dwV+H8rQFWr06KRzPYJduvoI1d2KY8
         CjU1hFvh3t5KTXYjXvKesbDWo3Mb5atbtxS2TI6olfQySOxAZpRm+KqwARepRF/Tzdo1
         oV8g==
X-Gm-Message-State: ACrzQf1sf8f9HlyA94io6Pbtf8f4alsZuurDkiY+Bp8am4xnEYpIfcQh
        CNVp9x5n1ANcHvBSSH8ELzZFyA==
X-Google-Smtp-Source: AMsMyM7k0roH3jCkb6xt7D1Zvro/Zuk6vqeMvaqjJH6flwqtNvU22inRWLKApg7OF++8lP5+gCYPJw==
X-Received: by 2002:a05:622a:30f:b0:39b:192a:3052 with SMTP id q15-20020a05622a030f00b0039b192a3052mr1066423qtw.412.1665685788188;
        Thu, 13 Oct 2022 11:29:48 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a0c4e00b006cfc4744589sm322572qki.128.2022.10.13.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:29:47 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:29:46 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-parport@lists.infradead.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Add linux-parport archives to lore.kernel.org?
Message-ID: <20221013182946.dqx6pcdlboyf7t5p@meerkat.local>
References: <20221012191201.GA3107702@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012191201.GA3107702@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:12:01PM -0500, Bjorn Helgaas wrote:
> The linux-parport@lists.infradead.org mailing list is listed in
> MAINTAINERS.  There's not much current activity [1], but I suspect
> there's some useful history that we might want to preserve.
> 
> Should we add linux-parport to the lore.kernel.org archives?
> 
> https://korg.docs.kernel.org/lore.html says pipermail archives like
> infradead has are not ideal, but I don't have any archives at all, and
> I don't know how to get even pipermail archives out of infradead.

The archiver is now subscribed to the list. Once we have the archives, we can
complete the setup.

-K
