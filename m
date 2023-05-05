Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB506F8950
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjEETMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjEETMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB811A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:12:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-74db3642400so199293085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683313925; x=1685905925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C16o67vTtiW5Sj95zSEy8qfd66g68CibYOi8W/wTXeU=;
        b=GZJWOSjq5YLUs3bzramzfp6vQP7hZAvgWOnsYiqq4w6xvhxRqrFhQRZHUgnEm62bb3
         G4QwIWsyqqJzNO+PVSMeILQKktJbQo7vgunwEodsBQ2NF3Wty2UoYDRfDMBLi8m9M7kj
         E8RgtVxaZPKfE17StgMTqjDxe2IsBWXxquuwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313925; x=1685905925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C16o67vTtiW5Sj95zSEy8qfd66g68CibYOi8W/wTXeU=;
        b=RtLZBikyZVP+Yih1WoHsW8w0TTyxqjgm4j1TTw4G8ieXh5SPVHplXbRapszTQpEpz/
         wuP5ck1HpAP3EOsxqkfuI+ujZMGYoYuBqQphNsuxgTbJUyk6W30K4FwnzrV16esKJY1E
         NlHPCLJ9KqlWC8ZMHIf3LAvgZJJWVAEYNxc7OK5nW7gGKf4Zyru5TzdLSkF+iGtq3mCZ
         vx6+piccSBLt3a+eLnr5Mn5eD1ltPLfEgkOc+QGm/S7rf9cAkz2M/KWGeX63E1N5mElo
         kWqOBEJUQ9AiSYulK4tmxg3zmzB0mYJADR1e9jNA3BywvONtEdLXS94AjxTiQ2YuWWOB
         i0pA==
X-Gm-Message-State: AC+VfDx0BZBNMuXfHmqXWb4+mOkntwrOw67JN33467IarPtdERMmL30z
        d4oIQZiaT+w7TiZ6CEky55ThJA==
X-Google-Smtp-Source: ACHHUZ7anJS/esKCfu8bEz7dpeuCicbGJYMxXFivH/mYdV0Vz+p7cTVrxKczFd82GvVWxH/PLUh20Q==
X-Received: by 2002:a05:6214:27c5:b0:61b:5ca6:b7fb with SMTP id ge5-20020a05621427c500b0061b5ca6b7fbmr4228889qvb.28.1683313924771;
        Fri, 05 May 2023 12:12:04 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id g17-20020a0cdf11000000b006210a12650csm42045qvl.145.2023.05.05.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:12:04 -0700 (PDT)
Date:   Fri, 5 May 2023 15:12:02 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org, linux@leemhuis.info
Subject: Re: Introducing bugbot
Message-ID: <20230505-lent-swoosh-4897e2@meerkat>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <20230505085218.60c62d75@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505085218.60c62d75@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:52:18AM -0700, Jakub Kicinski wrote:
> > Per our discussion last fall, I've been working on a bridge between bugzilla
> > and public-inbox, which went live in the past few days. It's still a very
> > early release, but it can do the following:
> 
> What about closing the bugs once they had been fixed/triaged/proven
> invalid?

For now, bugbot can look at a branch in a git repo and close bugs when it sees
a matching "Closes:" trailer.

-K
