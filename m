Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B47405EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjF0Vuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF0Vu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:50:28 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBDD11D;
        Tue, 27 Jun 2023 14:50:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 3550420127;
        Tue, 27 Jun 2023 23:50:24 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tqwoBdzOrYAd; Tue, 27 Jun 2023 23:50:24 +0200 (CEST)
Received: from begin (unknown [91.151.117.182])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id DF1862011A;
        Tue, 27 Jun 2023 23:50:23 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1qEGZp-008z2f-1W;
        Tue, 27 Jun 2023 23:50:21 +0200
Date:   Tue, 27 Jun 2023 23:50:21 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
Subject: Re: [PATCH v3 2/2] tty: Allow TIOCSTI to be disabled
Message-ID: <20230627215021.ajwlckics4ssquit@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Dave@mielke.cc
References: <20221022182828.give.717-kees@kernel.org>
 <20221022182949.2684794-2-keescook@chromium.org>
 <20221227234000.jgosvixx7eahqb3z@begin>
 <C95AF535-7A95-48BA-8921-1932C15A1931@kernel.org>
 <20221228205726.rfevry7ud6gmttg5@begin>
 <20230625155625.s4kvy7m2vw74ow4i@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230625155625.s4kvy7m2vw74ow4i@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault, le dim. 25 juin 2023 17:56:25 +0200, a ecrit:
> Samuel Thibault, le mer. 28 déc. 2022 21:57:26 +0100, a ecrit:
> > Can we perhaps just introduce a CAP_TIOCSTI that the brltty daemon would
> > be able to use? We could even make it only allow TIOCSTI on the linux
> > console (tty->ops == con_ops).
> 
> *Please* comment on this so we can progress. ATM people are
> advising each other to set dev.tty.legacy_tiocsti=1, which is just
> counter-productive in terms of security...

People are even discussing adding that configuration to the brltty
package, which e.g. on ubuntu is installed by default, and thus
defeating completely the security measure by default...

Please do contribute to the discussion so we can fix this.

Samuel
