Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CF678BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjAWXJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjAWXJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:09:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729393;
        Mon, 23 Jan 2023 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=2yiBuBGoTrixmTrgkcFPOfHpQ4Ci8FcqsNZWkUpBQF8=; b=TxcaEAJD/aVShcBp4WftQYqxYE
        IczJ3bd9zJLbFli1wGoUjvYhJ5TQQY+zQHVTcypPaofNdpUYsVB6dt7bkW1isw5Idt04HdFtDQkdN
        mb/+dBbz6NC/8h+MNgPPwR6EHGASsB9HY9y92vEGzq1zRl5CMFYrtUxQ7fKN0sftevCUpQKO9WdhV
        /5TiOunR4gM3haMlRkz9OCM41bdRw/y//u7MdSm6djOiXnlM8hMbpJFCYaOFUGUauVUWjskZg8n7F
        PVqWS1aTzTGn9EFtbIXVZTfGUNLn54hKG2DNbEzWk5CpDs64JwotMRJiFDtyMdQxQqY67OBYSGXXp
        QcYYMkSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK5vt-001oBJ-Uc; Mon, 23 Jan 2023 23:08:57 +0000
Date:   Mon, 23 Jan 2023 15:08:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Trilok Soni <tsoni@quicinc.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        "tkjos@google.com" <tkjos@google.com>,
        "Trilok Soni (QUIC)" <quic_tsoni@quicinc.com>
Subject: Re: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW
 contact for Qualcomm
Message-ID: <Y88Tif1aSjcdl20O@bombadil.infradead.org>
References: <20230123222220.405622-1-mcgrof@kernel.org>
 <CAKwvOd=uah7DxBfkLMnhS1hYRZxHVnW5z++auRYhGWbKZ+C0Qg@mail.gmail.com>
 <BY5PR02MB675447B5DB615762D339736BB0C89@BY5PR02MB6754.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR02MB675447B5DB615762D339736BB0C89@BY5PR02MB6754.namprd02.prod.outlook.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:05:57PM +0000, Trilok Soni wrote:
> On Mon, Jan 23, 2023 at 2:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Emails to tsoni@codeaurora.org bounce from different systems I've used 
> > and LinkedIn tells me he's now at Linaro since 2019. That's a 4 year 
> > gap where embargo stuff goes to /dev/null for Qualcomm if the first 
> > bounce happened in 2019, but I have no way of knowing when that 
> > account was disactivated for sure.
> 
> I can submit a patch to update it to quic_tsoni@quicinc.com . I am still w/ Qualcomm 😊

Great thanks

  Luis
