Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09B05F43D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJDNA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJDNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:00:05 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB961D75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:57:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so8851068ioz.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZaaERZiNeWPg1VEtskzRzem7azoo+jAPc6Nm8v1Mjr0=;
        b=7p0rX+YI19rz7LcJsDT7EUi/YO0MCOH3ss727cgrnIupMfIGfD2iXpCyyG/JRPV5Go
         FhTIl/NZXGS7NDE042e6rksdMF5ZjO+kIiIcdkQKj+X3rVjlqnjWJaDf3A4R9uEw+EAt
         CkEMhMXEFdchtF3sad9z/vkz/6ba/vll9NrEH6uuF9A2GMhC6T39WVqosGC7VmMmEIRB
         INgB7AYm5nwQhnWL5DftEtD0zXr+v2u+TERsrhY+QTRM8Jden/PikinxJpnsxQdscRoT
         mwtK8x26rzRogKIUezQuvEO4MFNgQ2hOyfhokwgiVVnrKSLJNFfkQ6F6FtWHzmeGuGhY
         zm2A==
X-Gm-Message-State: ACrzQf3RGmdPntw/HeqTLEIjfNjoRjzqFrcby4YcMJo/RfMytQog7nfA
        BuPoB8RLEaWuYvJJ3bnvSLdaumt0/1aAY8QmtI3yeiJxgCrc
X-Google-Smtp-Source: AMsMyM4kteE+NL4GAcjpCLq1LwFAhSOn3ZAssS5MrlayLf6b/No6LrtmBBCgIgSa0qYCffeg++X/hyr53V5k5Q4P1mQiqhP4JPvH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168b:b0:6a2:c6d1:d4e4 with SMTP id
 s11-20020a056602168b00b006a2c6d1d4e4mr11282718iow.190.1664888241655; Tue, 04
 Oct 2022 05:57:21 -0700 (PDT)
Date:   Tue, 04 Oct 2022 05:57:21 -0700
In-Reply-To: <PH8PR10MB6290511E9C0A3D20E1C222EEC25A9@PH8PR10MB6290.namprd10.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c183505ea350059@google.com>
Subject: Re: [syzbot] upstream boot error: WARNING in netlink_ack
From:   syzbot <syzbot+3a080099974c271cd7e9@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, fw@strlen.de,
        harshit.m.mogalapalli@oracle.com, keescook@chromium.org,
        kuba@kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        vegard.nossum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

asset storage also requires dashboard client

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build46036865=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at feb563518
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=feb5635181eb12a6e3516172a3f5af06a3bc93e1 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220930-160315'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"feb5635181eb12a6e3516172a3f5af06a3bc93e1\"



Tested on:

commit:         725737e7 Merge tag 'statx-dioalign-for-linus' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=36e3ab6ff9643877
dashboard link: https://syzkaller.appspot.com/bug?extid=3a080099974c271cd7e9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12302bb8880000

