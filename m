Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427AD6E338A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDOUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06DB35AF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 13:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BBD66121C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC4C433D2;
        Sat, 15 Apr 2023 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681590615;
        bh=FDqwyCewmATRO0gXxaXyHWDT0NCh4AcofbtsWcx+i2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLJpIMSsdOV6oGimRDztw5lS7Rw+zWHfHG8QIcumC82nxX7yQ7BaJSfyZHh8T+PTO
         hKGt2N3RBO1ILRUfYiqgDN2fLubl87OFAe9PpaUNNVUIzO63lrcjhCsc3IRikNPH8w
         5WdEH8DY/kKLqKuFdHQXKGTbOPC/ew+nGfdBtNDAVc2Nu9H0SFx+20mTzKSBJmEbCF
         Ep/5USAaKTOtb3Mw/LGs9sgs3KP8+4Diu1D2UE26ZQlTxMRH+wYHevNjNu9oZz0iMX
         p/ej7KfrEIv3CPy4z9b/MIBdn+fOeiVnVOy8jsjaLxZHkOr4ZdYtL9QxlJ8rqk3ln8
         VACgm87i6HL/g==
From:   SeongJae Park <sj@kernel.org>
To:     Ricardo Pardini <ricardo@pardini.net>
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux: change tools/vm to tools/mm breaks "make clean" in tools dir
Date:   Sat, 15 Apr 2023 20:30:13 +0000
Message-Id: <20230415203013.13759-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415202454.13558-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding below to mailing lists too, for more context of a patch that I will
send soon.


Thanks,
SJ

On Sat, 15 Apr 2023 21:27:18 +0200 Ricardo Pardini <ricardo@pardini.net> wrote:

> On Sat, Apr 15, 2023 at 7:39=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> > Thank you very much for this report!  I confirmed the issue can be reproduded
> > on my machine and fixed with below patch.  If you see no problem with the
> > patch, I will post it to the mailing list.
> 
> Thanks SJ!
> I've applied your patch against 6.3-rc6 and I can now `make` in
> `tools` dir again, thus
> 
> Tested-by: Ricardo Pardini <ricardo@pardini.net>
> 
> --
> Ricardo Pardini
