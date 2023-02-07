Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2568D1BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBGIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjBGIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:50:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D106367D9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:49:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a10so7367135edu.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cPF3S5LWjJlkZTrjV9Y73itlCeuHZIzU03BM/+gPvQM=;
        b=PbzIRdfIqKifArM2ew4zN4MoWgH1obTY0K7gfUmkXO36MoI0VdJDSmpzZvZE016XQS
         XBWWlxPCcJXRB+3GljRFv3eVIwaIuBGdwK1k/mbP1tf9+V9a4fp5FtjrvAmAaP0icgK6
         5nwCaGG3vvChOwiEuNoQCLc97hC1ebtdsSj1Ft4x0ogCbtFSES5xJza60hhNQhc4cyQr
         GwVNcrIGgh8LZd3BIJbjATPg+IRB7w95GXB/icylTDJf9NI5RDZiYwXGrM/a0x2/K6JT
         6l4otuL6/1SLz9fUPJaQLExhEpVpoxTZtHmCZAIS7Cd1lVuZdn+IROeXMnHSYDu9u7DQ
         eESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPF3S5LWjJlkZTrjV9Y73itlCeuHZIzU03BM/+gPvQM=;
        b=Y0XmRSkp2x72TILXnIuNrVVKMXy8tAgzAxM5Doj71FZdLEGKi0msaz5dWW2r06Zhx0
         yGPfKPbixNYWVgWnU6f8sJozUzPdhkfLkuinh5uUGy94cLmlAsWMfvM91qKzKSFTHZKP
         v9deBpJum0x4E7HZKLoqhABq3NxPZUCODR8nna9JQa1fJAu3FGvUytaUwys57OjgPc+g
         rc/fpaiUkUhdB4uKJCki2+1cwKRl6OnjN81ikXrVwNhu9QaDnaRMDLNlpNdflUAz4Zqj
         MyNWVDUgV3itHM+ElLWmQLpTNrDA+1Jan10ZeZ4/eaB5ZPO7d7CiPNnhdfJMT9RtA9jn
         CZ0Q==
X-Gm-Message-State: AO0yUKUlFZ8eUN6++DDxqZ0ZJMbowk/giEnPqPVAOfJp/KldS5RA7Wjw
        D0No8sMcCLBvSNMut68oNWM=
X-Google-Smtp-Source: AK7set9A1knvIGVWuHJUr4x35s1L2zt9irEF/Hck8YdKqktqiZBTaIx3AStOsDcBWAJSkXAkUsX1yg==
X-Received: by 2002:a50:cd03:0:b0:4a1:e4fa:7db2 with SMTP id z3-20020a50cd03000000b004a1e4fa7db2mr2482123edi.17.1675759797892;
        Tue, 07 Feb 2023 00:49:57 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id q22-20020a50aa96000000b004aab66483ddsm1815310edc.70.2023.02.07.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 00:49:57 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:49:55 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y+IQs0sDfJ+rxsmq@combine-ThinkPad-S1-Yoga>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
 <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:49:15PM +0530, Deepak R Varma wrote:
> On Tue, Feb 07, 2023 at 08:25:57AM +0100, Guru Mehar Rachaputi wrote:
> > On Mon, Feb 06, 2023 at 10:43:56AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 06, 2023 at 12:39:08AM +0100, Guru Mehar Rachaputi wrote:
> > > good luck!
> > > 
> > > greg k-h
> > 
> > Thanks for taking time.
> > 
> > If my understanding is correct, every version of the patch should
> > include all the patches/patchfiles and it should explain what happened in each
> > version(in decrement order) through a coverletter. Please correct me otherwise.
> 
> Hi Guru,
> Other than the cover letter, each individual patch should also include the patch
> version history in the descending order. If a specific patch(es) that is/are
> part of a patch-set, did not have any change, we should still increment its
> version and record "none" as the change in current version for such patches.
> 
> However, from the patch-set, any patches that are acked, do not need to be
> resent along with other patches that are still under revision. But do mentioned
> about such accepted/acked patches in the cover letter.
> 
> Hope this helps.
> 
> Thanks,
> deepak.
> 
> > 
> > I do refer "first patch submission" and above is my current
> > understanding.
> > 
> > -- 
> > Thanks & Regards,
> > Guru
> > 
> 
> 
Thanks for the info, deepak.
Is is possible for you to share some reference that is easy to
understand. It would be helpful.

-- 
Thanks & Regards,
Guru
