Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4946C0A94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCTG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCTG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:27:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD2576B7;
        Sun, 19 Mar 2023 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ymlj6tr7jc/Ds5qpTizc2igFIqLJSW+AJ2TX/23qHyA=; b=k1Unp9naWpT6C3jcgjEpwlJr9a
        NiEPfknU57CWh7L1IhjSPld91xn7i02IEhK1eDM+W3lrETC0YSWW38zKqliLeF64l7opZ++5lkcaQ
        l+4iyCtMIA2zX5Vp48GL2tL4M0UkLqeb47fn1ZIc9Tzi5Mlm84fbnFy9Qy40xycus1lCIuOepksJN
        gas9lJfg+wdtVbMwfzN/Ywtr4YwZhlk89aVe78eB7Awo5yJBwy1s3XLpcvOeZGFmAfpfnuYShOwEG
        g5nGkq652NYEj/gm6bbtV1G9P7WefZlIRZvEDli/vbTIxsK8g3FtkzfRiposFHRPV7VBmo9FG2Nk/
        YqaXQk8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe8yo-008ED5-00;
        Mon, 20 Mar 2023 06:26:50 +0000
Date:   Sun, 19 Mar 2023 23:26:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Moon <quic_johmoo@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Message-ID: <ZBf8qak4lg43MDgz@infradead.org>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <ZArlx5wrw+ZQWUg4@infradead.org>
 <c4b39b28-1f18-c436-e3c5-b015600ca3a2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b39b28-1f18-c436-e3c5-b015600ca3a2@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:20:14AM -0800, Trilok Soni wrote:
> This tool will be helpful for the kernel maintainers and reviewers as well
> if it can detect potential UAPI backward compatibilities. Even for the
> developers while changing UAPI interfaces at kernel.org before submission.

So document it as that.
