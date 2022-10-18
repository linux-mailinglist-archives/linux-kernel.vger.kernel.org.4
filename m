Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D91602347
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJREbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJREbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:31:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C34582750;
        Mon, 17 Oct 2022 21:31:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666067499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmXSZOocKWle7WJN1Yv0WbcwhJdK1zNL4uIqVNuJpco=;
        b=aTvWY65prFjEJWfbjZPDuU9HA16ainhU+vmOJqu4uPXJl/DBmEEHdZxEUZMyjRNh78rHFs
        YJ336DRI/z3mfMMn/GljrlxvZ2JFXgAlaKNos7evmPwW/+8nRr+az1lpm/rJO1cj1j4Iiv
        JCfhcD/N/9RmKq5HCY8aSD7SC1jcbD0zhm2FOzCLC8TQsWY4m7B4TgLUDIx2FDv/xYEBN7
        /rEP3e0xH9jiOhkwAAOdkiis4MX+QcRLV8XJJiFMU8LSJUCdreoxK0i6yX2dQcYKuWeJA/
        ZBEEjLOHSWOnUmY/hg2l0qqvfD1g07TFzF2yC+HILYzz8CKeA4LtZLISygJNEA==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH 1/2] docs/zh_CN: Add staging/xz Chinese translation
Date:   Tue, 18 Oct 2022 12:31:05 +0800
Message-Id: <fe66d342bc99bddcae14be2a4f2e189b8023c4d8.1666067195.git.me@lirui.org>
In-Reply-To: <cover.1666067195.git.me@lirui.org>
References: <cover.1666067195.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following files into Chinese:

- Documentation/staging/xz.rst

Signed-off-by: Rui Li <me@lirui.org>
---
 .../translations/zh_CN/staging/xz.rst         | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/staging/xz.rst

diff --git a/Documentation/translations/zh_CN/staging/xz.rst b/Documentation/translations/zh_CN/staging/xz.rst
new file mode 100644
index 000000000000..a50e7ee10bad
--- /dev/null
+++ b/Documentation/translations/zh_CN/staging/xz.rst
@@ -0,0 +1,99 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/staging/xz.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+============================
+Linux中的XZ数据压缩
+============================
+
+介绍
+============
+
+XZ是一种通用的数据压缩格式，其具有高压缩率和相对快的解压速度。主要的压缩算法（
+过滤器）是LZMA2。额外的过滤器可以被用来进一步提高压缩率，比如用来提高可执行数据
+压缩率的Branch/Call/Jump (BCJ)过滤器。
+
+XZ解压器在Linux中被称作XZ Embedded。它支持LZMA2过滤器和可选的BCJ过滤器，并支持
+CRC32完整性校验。你可以在XZ Embedded的主页<https://tukaani.org/xz/embedded.html>
+中找到最新版本和关于在Linux内核之外使用源码的信息。
+
+对于用户空间来说，XZ Utils提供了类似于zlib的压缩库和类似于gzip的命令行工具。
+XZ Utils可以从<https://tukaani.org/xz/>下载。
+
+内核中的XZ相关组件
+===================================
+
+xz_dec模块为XZ解压器提供了单次调用（缓冲区到缓冲区）和多次调用（有状态）的
+API。xz_dec模块的用法记录在include/linux/xz.h中。
+
+xz_dec_test模块用于测试xz_dec。除非你想魔改XZ解压器，否则xz_dec_test是
+没有用的。xz_dec_test会动态分配一个字符设备主设备号，你可以从用户空间向它
+写入.xz文件，解压的输出会被丢弃。关注dmesg可以找到xz_dec_test输出的诊断信息。
+详细内容请查看xz_dec_test的源码。
+
+为了解压内核镜像、初始ram文件系统和初始ram磁盘，lib/decompress_unxz.c实现
+了一个包装函数。它的API与其他 decompress_*.c 文件相同，那些API定义在
+include/linux/decompress/generic.h中。
+
+scripts/xz_wrap.sh是一个XZ Utils中的xz命令行工具包装器。这个包装器会
+设置合适的压缩选项来压缩内核镜像。
+
+在内核的makefiles中，提供了使用$(call if_needed)的两个命令。内核镜像应该
+使用$(call if_needed,xzkern)来压缩，它会使用BCJ过滤器和一个大LZMA2字典。
+它还会附加一个四字节的包含源文件大小的预告，这会在启动代码中被用到。其他文件
+应该使用$(call if_needed,xzmisc)来压缩，它会使用1 MiB的LZMA2字典并禁用
+BCJ过滤器。
+
+关于压缩选项的说明
+============================
+
+因为XZ Embedded只支持没有完整性校验的数据流或者CRC32，请确保你在编码未来将被
+内核解码的文件时没有使用其他完整性校验方式。使用liblzma时，你需要使用LZMA_CHECK_NONE
+或LZMA_CHECK_CRC32。使用xz命令行工具时，使用--check=none或--check=crc32。
+
+除非有其他环节会验证解压数据的完整性，否则强烈使用CRC32。双重验证可能会浪费
+CPU周期。请注意头部总是会包含用于解压器验证的CRC32，你只能修改或禁用解压后数据
+的完整性校验方式。
+
+在用户中间中，LZMA2通常使用几兆字节大小的字典。解码器需要在RAM中放置字典，
+因此大字典不能被用于那些意在被内核解码的文件。1 MiB在内核中大概是可接受的最大
+字典大小（可能对初始ram文件系统也适用）。XZ Utils中的预设值可能并不适合创建
+内核文件，所以请别犹豫使用自定义设置。比如::
+
+	xz --check=crc32 --lzma2=dict=512KiB inputfile
+
+使用上面字典大小的一个例外是在单一调用模式下使用解码器。解压内核自身就是一个例
+子。在单一调用模式下，内存用量并不和字典大小有关，这种情况就是使用大字典的好地
+方：为了最大化压缩，字典至少应该和解压后的数据一样大。
+
+未来计划
+============
+
+如果有人认为有用的话，可能会考虑创建一个受限的XZ编码器。LZMA2的压缩速率比Deflate
+或LZO等要慢，即使在最快的配置选项下。所以并不清楚LZMA2编码器是否需要并入内核。
+
+有计划在解压代码中支持有限的随机访问读数据。不知道这能否在内核中有任何用，但是我
+知道这会在一些Linux内核以外的嵌入式项目中有用。
+
+.xz文件格式规范的一致性
+================================================
+
+在一些边缘情况下，为了简化事情牺牲了尽早地检测错误。因为并不会导致安全问题，实际
+上是没有关系的。但在测试代码的时候知道这一点很好，比如测试来自XZ Utils的文件。
+
+报告错误
+==============
+
+请在报告错误前确认是否已经在上游修复。可以从<https://tukaani.org/xz/embedded.html>
+获取最新的源码。
+
+可以通过联系<lasse.collin@tukaani.org>或者访问Freenode上的#tukaani
+联系Larhzu。我并不经常阅读LKML或者其他内核相关的邮件列表，所以如果要告知我什么事情
+，你应该通过我的私人邮箱或者IRC联系我。
+
+请不要因为内核中XZ的实现或关于XZ Utils的问题打扰Igor Pavlov。虽然这两种实现
+包含了建立在Igor Pavlov的代码上的重要源码，但并不由他维护和提供支持。
\ No newline at end of file
-- 
2.30.2

